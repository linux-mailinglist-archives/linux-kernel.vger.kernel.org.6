Return-Path: <linux-kernel+bounces-372234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085719A45F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A902A1F244F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4F20E312;
	Fri, 18 Oct 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQU+q6Ri"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280A2022D7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276614; cv=none; b=FwahHdu0RvvXmWQx20/D0henFPZ+yH/DI7vhIXd9iNyY/8DdEQtjJx1c5HScWTiOQm2pcuEsAjcoGUEeUDmo/oKW+sErKhQkFe8u17Gc0wN+VrgQzGvOE/VBOmZsC2j244iiykUH3TWrSn19+h3jIDg3YrxqxwqRyWSz8NgHqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276614; c=relaxed/simple;
	bh=D3G0l9jbMvlCkvgoc+kjUJNNTFmI2ix7sVeYwkEJuOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Khb85LFkhMQKvlPLQR+hWuMylcRjZHo4W0iwVkjmVSrhD5tGuhdssFZRSzgU1pnexsU7FjAhsczT5OAcETw7Q8PoUBMm7MXno3mFvc14no3RvbNmWKhRinqjllRzikf6GDjw1t5lpO4YZcpLQ09rIqGDSgkIXNeDWh6Fhhne8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQU+q6Ri; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d2e71de18so735578e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729276610; x=1729881410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx5yoM9lQg2y1MsfWqtMxM0GetDzvGAcfS6YYX5arXQ=;
        b=MQU+q6Ric0vLIvMljLPT075quKXNL/dK80iU2dGUHampxlvQrCiytqWvlAZG23jr0A
         7InwhKIdlLcLW/d6wPtFWPYfpQMfrLZNHH3lKsU14BqmS9PWry69JQbqXBtskWDQBzNJ
         c8nB4codZofbc7xXjH68kekil/pPPM24OKrt1hrLOGuPccZiZL/kh0KhwbwN9+81hUcE
         juTC6QuRfr2WCUVT+4llQOn1zpC9WKxaWWVQ1iAKdk0JwoJT/odFRBTxv5hqoKnRQKaK
         nrFPAFfpo3s8YT1R7bxgTQKrTJppk+5uBiHHJPE3enpn+2ueTGXHcShXjX1nBTZZaFPk
         qy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276610; x=1729881410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx5yoM9lQg2y1MsfWqtMxM0GetDzvGAcfS6YYX5arXQ=;
        b=J4l+D+RuiiFQemNLgtzpkijtvkykFQ5cYxdHhcagb82aj1Wwps7pTiNSzgigIrKBxM
         lY+SdeGk+Q30UDIsgKZhC6ip4FWy1lGBogN0o+i7R1iaMh1NofQaJaW5iRSL5oACPWiv
         8Ey+aPNIfLRIElXng4oFWtnaf728XttyWNdgsLWeeHumbt+6SQVg1YgORXLLHSp3H96U
         gyYpCfkc86pdvCmdDPoa2ViEiUI4IreDE3ET8ka9XBLN5iOubBl2O2063tDeE57IrJy4
         jKSmcEtRi4AWNDm3mBdcehkmycF9/N7PXZtt6SLgm2k+b1SIl/O+71EIu6ZbLKnfmCnA
         DdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5wa3BVtu4ExRZKnrVVCnQcfLq1iY/RYg5/GHLbRFSAppbrDGXKXuRFLEbraydq7KhRU7KMjPWAhdtGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqDmrMBS3eo7sKc0ozJArfxENxdmfEALcpzVQcOK6oTr0dODz
	ucmsayxqV+n/66p5atSRBX3IDYVhsGu8P18qege4xd8LguUcl6lCqdPnHp3zGUKHleVCvB8K3iA
	UQb1XHlLCe6SBFLG+ELH3igPxt7U=
X-Google-Smtp-Source: AGHT+IEow0bGucLUZ1EAJuePRFrAKTAb24joUPnIV4vUTrT/pXMPFvfyGUsiAjxf8rRzvpLQqHL1GFyZxA3goPQDvUs=
X-Received: by 2002:a05:6122:512:b0:50d:5654:951 with SMTP id
 71dfb90a1353d-50dda170c77mr3295182e0c.5.1729276610195; Fri, 18 Oct 2024
 11:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com> <20241018172804.GA2151929@nvidia.com>
In-Reply-To: <20241018172804.GA2151929@nvidia.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 18 Oct 2024 19:36:38 +0100
Message-ID: <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Aug 07, 2024 at 10:47:25AM +0100, Pedro Falcato wrote:
> > In the spirit of [1], avoid creating multiple slab caches with the same
> > name. Instead, add the dev_name into the mix.
> >
> > [1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato=
@gmail.com/
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  net/9p/client.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Can this get picked up to rc4 please?

FWIW, seems to have been picked up into 9pfs-next
(https://github.com/martinetd/linux/commit/79efebae4afc2221fa814c3cae001bed=
e66ab259).
Seems like we're just missing a PR to Linus?

--=20
Pedro

