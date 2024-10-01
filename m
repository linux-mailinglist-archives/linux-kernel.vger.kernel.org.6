Return-Path: <linux-kernel+bounces-346251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1298C1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D094B1C21F10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3891CB308;
	Tue,  1 Oct 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNC7aFeF"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6031C8FD5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797104; cv=none; b=Xji1/nBOekuHvmlAGTyfw8ndUyaozqKtxxRmsvljB0lxnjW33YSDtBgcC/WRlhBvjOcFWK5ExbsL6soDRYoSPdITqnVt4yanysAFpGyGKDyoNs9OpIRy5oiZCWfuLibh61cb6N/A1bFI6ShK1ywChb8rLRlcXbOD5AvlIOKlBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797104; c=relaxed/simple;
	bh=BND0UrfW364/MzVvY05GOVxbP+4Yd4Vn9qtlhmUFbaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKP/Sfrir93FJ/GVMiyaLJWOeweOPRaUGSQvqVwKCt+qwV9sE3AyOsifBnCTMTZneDFGyrf4oS2XyS8ieqH02xsN8Y+AN6B17tZ7iqrH063QebEIknKhBTyBmKnC9NnyacsjEQReXczRP6EpAW7pER3J4bzXg+b2wX/M1PqopLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNC7aFeF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398b589032so5138116e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727797100; x=1728401900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqG/eZTTTQayqI76/b5W32jByhojAkXkgiM0WUlvwcA=;
        b=YNC7aFeFN6WFOtbNVRrkqeOtUqCY8u+OMgCHiQnwBYYkYG3Gjf3Y+VHSpvH3oIzFOb
         JHmK745lK92eIOHjckZB9brdwS4SK/fKUW6zZ3Jpcnq7vkfdiJr7mfREpw6ai1qZucGh
         exOggTacYImK+3nLDtYZ0yWdFTwXGIHW9t8EM7spuV76wL1Wdp1VRcTSGkQRCRhxHD7b
         9nTUzdfegrRo+q8xTjV3nt7FS+ySgvLc3aTC9PEBEtEnoAEsLaSoRxFpSkcnP0nIRhVF
         trS65TtB0RVArl9nKYSE2csuokZJjqzx2ScfUww50VxW+O7oWcgSWBg2oo1gE/qOk9i5
         RaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797100; x=1728401900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqG/eZTTTQayqI76/b5W32jByhojAkXkgiM0WUlvwcA=;
        b=lDv8DdsspYiqTStMzBWBIyvbPrK2xNsPqEkeO8yya6Baf0ZgeIJIdVFRMz8hyV4eHr
         VScvQjEEenJ5xOCEQhwiqijVZp86C05rPBzYzfNckExYjpxZ9W2MsX+l4UQ7SH1pnM09
         DqiK3PaLmGjL6oAEXpo5N3VO1a0R467xjOc+8v34zpn8wrDR6h4ir/OqP5qZee/a4F2Y
         RtVDacr1UAsypl2V74l3e61jFH+Qy+ZWc8RQ7nyRAQvMuoG7yLCk4CwmZPD0evcweK23
         Wz6XSLceG7bpZvBpYBVRrhzUJw3+P4suLSpA8YVDrTGHdfGkgJsLTpLOrB7emrCj8nxx
         flZw==
X-Forwarded-Encrypted: i=1; AJvYcCWzFIXl+/11cnY6hSGd89YkL+Ot+RMBNU6cUcY2yoLFqFIJNv0ZGBOGi/2n7yo/E8Zpvr7ccOi8c+SpUh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMvXbZFyZSTnJ+APa4CutnCuS8ppPlv703HCkI+qZgqZRG7gv
	6+l3HAuJ8ec4WPUXWdfgwjV2lbOzJ9sUi0hOMZQuHNhf3Ps7EdHJ3fxaMSc72sihpR/TnubWtrr
	MTwtGZ4Wkb7tx/mOb5iiNQ7XVrgh96J+cEAzw
X-Google-Smtp-Source: AGHT+IGb3Ciamc/UwkGofd5mT0NvV4MBat4kpwOCEGSftcqIj93SYf1WITZ+USR8SqoC6UFoow9qu2q/uCGujgB5c2w=
X-Received: by 2002:a05:6512:280e:b0:536:5810:e89 with SMTP id
 2adb3069b0e04-5389fca2d7dmr12113192e87.49.1727797099606; Tue, 01 Oct 2024
 08:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930210731.1629-1-jdamato@fastly.com> <20240930210731.1629-2-jdamato@fastly.com>
In-Reply-To: <20240930210731.1629-2-jdamato@fastly.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Tue, 1 Oct 2024 08:38:07 -0700
Message-ID: <CA+f9V1O5QZfbgVVpQgikgOGSP5jmTAbrOn-3oT=AEnsobg6U+w@mail.gmail.com>
Subject: Re: [net-next v2 1/2] gve: Map IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:07=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netdev-genl interface to map IRQs to NAPI instances so that this
> information is accessible by user apps via netlink.
>
> $ cat /proc/interrupts | grep gve | grep -v mgmnt | cut -f1 --delimiter=
=3D':'
>  34
>  35
>  36
>  37
>  38
>  39
>  40
> [...]
>  65
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json=3D'{"ifindex": 2}'
> [{'id': 8288, 'ifindex': 2, 'irq': 65},
>   [...]
>  {'id': 8263, 'ifindex': 2, 'irq': 40},
>  {'id': 8262, 'ifindex': 2, 'irq': 39},
>  {'id': 8261, 'ifindex': 2, 'irq': 38},
>  {'id': 8260, 'ifindex': 2, 'irq': 37},
>  {'id': 8259, 'ifindex': 2, 'irq': 36},
>  {'id': 8258, 'ifindex': 2, 'irq': 35},
>  {'id': 8257, 'ifindex': 2, 'irq': 34}]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

