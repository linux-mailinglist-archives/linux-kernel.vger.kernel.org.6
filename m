Return-Path: <linux-kernel+bounces-409906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DF9C931F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BFA1F23258
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EF1AB6ED;
	Thu, 14 Nov 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnqFLEdH"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BD19D088;
	Thu, 14 Nov 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615520; cv=none; b=gKYsQnDMjjI9NqPEUt4X/YYjzM9QeHrF/9LxcX0BF4dXwFhAu5t5ZYfLeUWYumNjmsSb045LJgMtC9HwoO3q+jF7dEW1a1ei977OTIkjhJk7yl9Q6Nk1wBp1KU55G84gY+D0oINgfyrOVH5kMAgmB9wWH1B5KuVjL+mJ8cZMf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615520; c=relaxed/simple;
	bh=EboaDVUcLyZYEShXKCV0PBGa7A9hiirKn+DHh0fT2zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRgZMiEUFOeIQgbJwxiMYE5T4mvl+pmqfuT5nYd693H+alfTukAqnX1WDRFGEfrFkgE3K3jRBWWejlGjNOrZLfeKsZotp+9TidM14xneX9cBgFA3JxBMBztFB8mTE5qORTXt4lHRCUFhHub+70bKIj1HqBzmBiNnDz1j0hYW4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnqFLEdH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso15411201fa.1;
        Thu, 14 Nov 2024 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615517; x=1732220317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EboaDVUcLyZYEShXKCV0PBGa7A9hiirKn+DHh0fT2zE=;
        b=ZnqFLEdHM7h3BuzAZ202jRV+MGFXdlTkVkBfDzPLn1FG/X9aSrkxDwJMLxThAoPiyV
         kJn3oK8ZZm0eSmvlUd/2cQZ6S/PWdzCK6ubAprvIL0F6LA2mo4AO3gf4TwDwbTw5RW/I
         cjt3bWOfqG34LDTwFPo+GqAtuF1C1/nGTcpiGPqqBYvERJuvMQ4qIR2h3bqc4s2A9ghP
         Q4RMgyvPP6TKwfBgEzGJDCVnW9Bvx+wWONwhtwM/53uRDUgUSHjB9iHQhE9CfUxJo2Je
         fU7xVhqGPacbyplSRX9uQu/n6w6xt/mNYYPZDE7fedsDgJC27rwovSuT7Qk8VqhepUOV
         bBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615517; x=1732220317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EboaDVUcLyZYEShXKCV0PBGa7A9hiirKn+DHh0fT2zE=;
        b=rZu/lGqdhohg6+xX1XqJPeoKOEZdGSAibmv6t1OA81InaDCMhc2rHyQho1E72gJVZv
         iBrlzETzfQC4A6ndqCWkV4eOLS5DMvPURGFHz3t7Pbs794pUWf3OfBN5WvQJbg9HysSy
         ThEYdZRSl+C5SDcSN512wq/4RHlVIjtHry6CwkHj74uVpivgal0hr48fXJ6praLpDFGn
         GTI9orszB0He3Z+nzIVRGHY4xNDLrjDBj2DIAcTsDm3ptc2WHH0ihJUAN1jfXmJLXQAv
         bkkVBsjXMBN/BKMDQFE4k/LBNjwChEkqHkDtRLqf8j0zqtBCw0yzHGIhJ3+pVGlSfR0/
         oUYg==
X-Forwarded-Encrypted: i=1; AJvYcCWo1yWZfNvrAQImJgy90vqOd9Med9B+BCBaCqMQQvE4d7aK172RFNYEMuxmTsvUz5gBQ0Aa5W5H1VcP1gRbMeCl7N7mbA==@vger.kernel.org, AJvYcCX/d6I9xwUuoIXiRmzJb+ktc21qcue8TG2jwqJKEVqmirmbjCEbMLG8COGgefGB3Ydqy8HCkT82Bv5Cz+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmF9ez0HS609pF/dgAMAoK8vndaLEvpOQk0/zTwXHnu7Q8X+l
	Ae3WUgIRsPuf0UwyPEAyW9XJAm4/WWHJDU0tgtIuThMuFDepeNvluVfE3JO8NoJIFGUyi/ppqyk
	/vDbSdeu1R2lEgbSLeWWWelt9bFhisp45
X-Google-Smtp-Source: AGHT+IGBe5R03bFj5XNdztQdu4dZVOmaG50L1laMpLAcM2+s8biNcUW6/kOhR29g8eDtQR9l+/pjD8HHqlJasMwvFRs=
X-Received: by 2002:a2e:a80f:0:b0:2fb:5c84:929b with SMTP id
 38308e7fff4ca-2ff606fa5admr3254541fa.36.1731615516644; Thu, 14 Nov 2024
 12:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114193808.110132-1-hdegoede@redhat.com>
In-Reply-To: <20241114193808.110132-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Nov 2024 22:18:00 +0200
Message-ID: <CAHp75Vcbz2o91qTucCw0BKQ8tR2Tzy68wanczOsVVooROxTyvA@mail.gmail.com>
Subject: Re: [PATCH] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:38=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> On N4100 / N4120 Gemini Lake SoCs the ISA bridge PCI device-id is 31e8
> rather the 3197 found on e.g. the N4000 / N4020.
>
> While at fix the existing GLK PCI-id table entry breaking the table
> being sorted by device-id.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

