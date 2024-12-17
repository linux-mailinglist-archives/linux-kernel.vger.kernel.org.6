Return-Path: <linux-kernel+bounces-449094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D029F49B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A20188BBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F91E47D9;
	Tue, 17 Dec 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBIp2FZi"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7916ABC6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434311; cv=none; b=CVVe5GKX0TIcDEzvvAm/tP+EwRqk9xWucso02WjxIlq7Rt5egqXAxCUHlsFhEv25LuI8IY11KfIzk9d+OPflW5pp868tXRI+Qggsl5UrEMGMToPAMtVg2fojPSSxtsDlALh97IQSDOQu/beMKFbun+b1KAMpIY2W7+sWSkgVit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434311; c=relaxed/simple;
	bh=n2e27FrUYR6dXBmSMBQNUCxtZXtXod+Q2RpGbooMcSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RayTvfwS1oZOeGHyF/jsEQ71CiPfkGXGMMq+5yvoBUiJff9dtGHle1bFGijcvufX7Jmpe6fGQfj78/DTvIDIoKIfTCEKP8olJ8p1uiY/CbpRywP6kQ3Yd1LmSTUuM179lGZbOVpSRzcPXhsz9TnI98FPE2Fm8Ro8mIXwpBArIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBIp2FZi; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so321626139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734434309; x=1735039109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1+lVSzsebFBMkDGJuafpKQ0aBmf15PYA5xQGfL/VsQ=;
        b=DBIp2FZiu82ikvT7Psd/lJJkk8YaOczpJXiu+GNN2lYsat725gI2i2lMmvxLLDtAUH
         xq8LY24dbLnXUEANcAmIDt0X0RU4vLRQ2HUYKRd23LnRaMczivqeGWbyhMiSmaYcEjgq
         9TsEGuM+r1o6lNy0uX+uKjC7KUD2r65SlmzmrpT8OUk0RnGdfG8MHUegXaZIJsWByGcQ
         MbruIb+uVlRsCQVpPGBLfuZj93gVEDIkwdx1FmkCEg+X2pKyck82CrEbwaQQLQqE0JMB
         FudytCkuRlr4BPVeLOmuHIyjEN0t1w9IrDiXVFzBdrdkUn9atK6eJsg44oKTxoMLkyeg
         T31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434309; x=1735039109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1+lVSzsebFBMkDGJuafpKQ0aBmf15PYA5xQGfL/VsQ=;
        b=gTcId2rQ96OmH3nCUE2QpgwlwbQwc3GA5gslDIU3t+jDp5y83O0jUuMqPIOe03dFBP
         hZKXUsP32jKOmS9lEWDVahjFGX5/LPBio16dlFfIzfbg2IC94mgPLeDS7oJ25R5w7937
         BQciq9+4asr8LiAQJJ3gx9wvJLL/6ARIdjArF6l/rd1wP8vnp95p26Tg0FDW39D3kd7G
         wEtF9BQ0Qy+zlNXs4rcUGulWJ4qLJnDnuMcBf6QUvHqAh2+mBS2FNPIbK6hh+38kaNWB
         4piPL/I2J1Onv6vhKnWbDaZ+DDMN2jU8CN/MND6BScZVvBZu3dd/UoAkTwkVXZcUiGx8
         McHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkeh30WM9nf567YHB+oAhB0N92lgT66dxCf0AdbLiogfQVmMKCdedyK62F8e+pYBhCMfwdbK9xkTxi8e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySE6snh0saGzSSd5ZEUJPEH0p4YsWuzBE2hDsl5YrCsPmLEANP
	Rpo7wh6QXNm1lCJpotHLwQDwEy58nz1aJoQwogIbBB/l+AP+/hhL4UqLza1niRbY1KQjb/MBz3/
	t8mbXCJ829RVPACVUHntmWXdtgkWDs2zdLxPJ
X-Gm-Gg: ASbGncvyHf0h41mP/YFSZRJwEYqE0N8rBsB6fAVTaZUHNvZNNfTbRin1AqglwE0FIE/
	dQA3aBwW8mbsuZ/lfL1sGXM5QtdnQGChPmbGs2duKU5PXQgwgiWJqNHwNUYlb89fVYjU=
X-Google-Smtp-Source: AGHT+IHSgUICatngFDKsLlfJZtWdjdQLFfiFZmgQSZZfOD+iv95mJRnW/sRvGTmpc+dCci8p0d7CInQLAfIlyWHm6uY=
X-Received: by 2002:a05:6602:6417:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-844e8802107mr1704393339f.7.1734434309341; Tue, 17 Dec 2024
 03:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com> <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
 <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
 <Z1i0d5Ht8zUHhSu-@kbusch-mbp.dhcp.thefacebook.com> <193b55c7998.d66e7e7c1942154.6474606603462169748@collabora.com>
In-Reply-To: <193b55c7998.d66e7e7c1942154.6474606603462169748@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Tue, 17 Dec 2024 12:18:18 +0100
Message-ID: <CAM5zL5pBfQQyRqjd5iV7ouTTii1sCD5fZJWE0zRkGkL18iz+-Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe <axboe@kernel.dk>, hch <hch@lst.de>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:56=E2=80=AFAM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
>
>
>
>
>
>  ---- On Tue, 10 Dec 2024 21:36:55 +0000  Keith Busch  wrote ---
>  > On Mon, Dec 09, 2024 at 04:33:01PM +0100, Pawe=C5=82 Anikiel wrote:
>  > > On Mon, Dec 9, 2024 at 1:33=E2=80=AFPM Robert Beckett bob.beckett@co=
llabora.com> wrote:
>  > > > [...]
>  > > > I have no further updates on this. I have received no further info=
 from the vendor.
>  > > > I think we can go ahead and use the alignment patch as is. The onl=
y outstanding question was whether it is an
>  > > > implicit last entry per page chain vs simple alisngment requiremen=
t. Either way, using the dmapool
>  > > > alignment fixes both of these potential causes, so we should just =
take it as is.
>  > > > If we ever get any better info and can do a more specific patch in=
 future, we can rework it then.
>  > >
>  > > I think the 512 byte alignment fix is good. I tried coming up with
>  > > something more specific, but everything I could think of was either
>  > > too complicated or artificial.
>  > >
>  > > Regarding the question of whether this is an alignment requirement o=
r
>  > > the last PRP entry issue, I strongly believe it's the latter. I have=
 a
>  > > piece of code that clearly demonstrates the hardware bug when run on=
 a
>  > > device with the nvme bridge. I would really appreciate it if this wa=
s
>  > > verified and my explanation was included in the patch.
>  >
>  > I've pushed this to nvme-6.13 with an updated commit message here:
>  >
>  >   https://git.infradead.org/?p=3Dnvme.git;a=3Dcommitdiff;h=3Dccd84b8d6=
f4a60626dacb933b5d56dadca75c0ca
>
> lgtm. Thanks!

Looks good to me as well. Thank you!

