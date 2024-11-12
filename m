Return-Path: <linux-kernel+bounces-406473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BD9C61AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2622FB2FD89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E32141A4;
	Tue, 12 Nov 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HOwxMVfS"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375C2139BC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433942; cv=none; b=pi7FcTqWX7rOwnbnF/1rY1/FZjWf7cik+IsBW0xKDiJTJospXoH+JWcEKBUTK0ZQpMirtOydwOrAPuqCRMbRi8kG4CC+MJ1N9dTlnabGfnjsOgt/0QdSCrU1q/X0bPZzQbCszRNIgqbb7SdhfN78oXEvkmz4z9a+KYLEPMq6PzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433942; c=relaxed/simple;
	bh=rF0m3RHCDCu5flwjKgaX68jhNqdc11TxTrvhrmCBPPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etuocQzxojhn8fZKvQK3jWNJIKpPrEuur32lepbSXhSdPBql/oag6u/uVywXCfZx/Y3+LVL5VdBZZQaEkIRl2aMwj5ySX+7zezvMXVrLbAmtsK8S9djGqPJmnGsJP6s0ShbTXMYmLxV9ZAAnAb5itzYEWv/zxUXOBREzMbYDn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HOwxMVfS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e9f8dec3daso46134377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731433939; x=1732038739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4eyKsihgIZD98hfy0JGAdD/M8t7V0X38hx8vGXpfi0=;
        b=HOwxMVfSDYQ+RxVYbxIKybq63fDnnIv3ifxeI3YXFf7c7AGzMw5A621vYXjS+UFgyI
         Qp/I3I/uhNH+XQTOdmdzgHc+lCIeWwzVz0Y4VOutOEJ4vNk3L/nzxVOyjg2v7bRGV4lz
         D2HDdEGPwaAevGXkFysfNgBG2ELGQXVK2qpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433939; x=1732038739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4eyKsihgIZD98hfy0JGAdD/M8t7V0X38hx8vGXpfi0=;
        b=JieB6P8ipHG8bSpwnLVo0k/4HDWfoRjxa1PXfs6MCLGpeJMQ9+H9dO8FRIMulf1XEi
         k/XSefCFbnVwpNJAG8CeEbB6Mku0wJ/+Zm4LD6TK6ObZ9fmwDsE3vNAPtRdxTBy4rj6N
         dFH/+AFFvELboJg0A4frp6ZjdTbqYIsmOM2AIs4zyyfIujHhqpb5xHUJjGrr9BEuFes4
         LVVBTB1kcLDtu7uGpstBdDwe3B8KiH0FeIioaiyZI3ZBXibMZr7JqTGhwYQmXGmtbm2K
         nERCZPPrEc6ln1te1fQTZnOhbNT0KHySwswG0p3XzyEZr28xxUSwv6p1ytPZOTxxSNvi
         xzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUkPMiFKBm8apm2XoeRDBh+KPml/7ISB5pF3jSTZbRGf1SdO87CY0DVQ3Sui5ceWp1UROmwUdU2Qi87fuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75br8qsIOI3tHwfDCMNLECEk6sf25TgGr2JMd4rD5t9C3B7D9
	lKA8Dw+SBulAEyNYMlCbAmwAynl27OA+RZCf/cHL1VIyjZ1+GmeK/GJZ1JVsoC5niaaGGcsR7Ez
	/2zR9XWtQuJYmsNljIBDZLCP96tMBdZlVn/XCug==
X-Google-Smtp-Source: AGHT+IGvEcIbEvzGr1VmCsZ0mQRwAsSPld9R2C5JTh0+fNcSwWaec7ZBqYSyzKL8e3qzWUzVn7JzLdpmgnyRZvU5CZE=
X-Received: by 2002:a05:690c:6211:b0:6ea:3313:f98c with SMTP id
 00721157ae682-6eaddf8430emr155761917b3.32.1731433939616; Tue, 12 Nov 2024
 09:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 09:52:09 -0800
Message-ID: <CAADWXX88Uv+r1JtpnN2gDv6S2wDTqxsn5x8+-U_xWfeNxmT9NA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] add _statically_true() to simplify GENMASK_INPUT_CHECK()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-sparse@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:05=E2=80=AFAM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> v2 -> v3:
>
>    - split the single patch into a series of two patches.

I haven't actually gotten to the patches yet, because all your emails
end up in my spam box.

The reason is because your git-send-email setup is broken, resulting in:

  dmarc=3Dfail (p=3DQUARANTINE sp=3DNONE dis=3DQUARANTINE) header.from=3Dwa=
nadoo.fr

because you claim to use a wanadoo.fr address in your "From:" line:

    From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

but you actually used gmail to send it, and the DKIM hash was
generated by gmail:

    DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net;

And then DMARC complains because the From: and the DKIM doesn't match.

So to actually get the right DKIM hashes, you need to either

 (a) send email using the wanadoo.fr smtp gateway

or

 (b) make the sender be that gmail address that you actually use for sendin=
g.

Pls fix.

                  Linus

