Return-Path: <linux-kernel+bounces-212730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4C906569
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355A8281070
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E313C664;
	Thu, 13 Jun 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCdERyhg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9713C3CD;
	Thu, 13 Jun 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264514; cv=none; b=IHA95ENO+WjvgFCRQ6HYKVtHdF9NiimE0r9pJnBmwGkX/Luvtp7mZR4czR0jZIw9EETlFa3ANQGyHye3aQ2aiqmm7fMybw+G87rci+9qTQkCfcH+nco5hNKZHnCMOBnPviyqtpf/ZnMH9hMLo67e/iES1oVRN14aowe+R/iwWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264514; c=relaxed/simple;
	bh=QTXRAMtoUIJ4ah8fs32K7LdYc/WpXQ5FPGOHsYloL40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs9RvxC5NiDoDmNtiDf/66Avh4/5xCi8lb9359Ka0cDWzwYKec646Axi3lBB+mjDMJ9LPXiUwxKTosDhPFkahOCW0Lw5JMSRcFY/Lp5aFihJbHZluIN16ViANsP7iOHDGqz9WIGWa8gS9W8qzhEUu31EQ0uJ+KC09uA8DTyAsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCdERyhg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43fb094da40so15694351cf.0;
        Thu, 13 Jun 2024 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718264512; x=1718869312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpwMjt4nCXN/KG1OXl7Qh7A5KjxtVryyFzFBi/3Kx/M=;
        b=XCdERyhg7DVrC6ZFNYsUYilUHJjoh38gDOpMOiuMDtPzgqQ89uX+zyrNycu4L2NxVM
         CJBBdieK2fjZ1WXMI5+TJQpY5J+NNp2FJybf/wrEBOph3tYPPH2u/mW4kvT7UyBDooWe
         FlbYqakfVln8MQewIrGKOYVKfETYy3mmrU8Gg6bgdjY5MGUv6a6fd20XoCrf8Rzb9A45
         dDovVVk/Bi0EmbTHvlYTPlW/CA09loADr2Yyj10r3xDgDDhqf7VJn9kQGWMSNs3tH/6D
         Oj7REVsqJYO8JOumGFMEYSzk6BVWjr6Ypktp92OZCXt51odAqnlIf+VrAPCvJHUPJx75
         0uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264512; x=1718869312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpwMjt4nCXN/KG1OXl7Qh7A5KjxtVryyFzFBi/3Kx/M=;
        b=Uh5xFivJsBBPrPw5gw6j0bdy+7kPyOipqQuU0SfsKeuOb8oHb+eXdHqiit8Rrdw820
         wOHXjtpfL+OtC2TmSel36J7HbCQ/sumhhagtI5T7mX9byoFok1QS4d4eI6f5Zhah3ARQ
         OJLFYVviWwnvcs8ypYU39IY1SR0DhqLC8+1RwFANAQvcSkybXpZoNkkQMBIhRvBkv3Wo
         q9cScPE79e7ZyMrJEDaiJqrufErPSj6qtw+FqEke/UMLezx4ggdI/uUf+AMVFmh2PClQ
         odbdg9YjW3re41Z0/6OWWxgpgID/T0SAzAnPr6y8VxY1pyDdyazaCUw7Mc9F95Tiq1IS
         ki0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzGE/gqbAMTwchs+3lmwgwWtVZirkr5SwL8DMR9/hna3x5EfemaWG0RGjIEeRfbNOhax5FRe7Kmu04EOeI2v7/g096qt802H9XV4GMAg0v7dw9KDvTk1sD4XlA1FrykAEnJjG+t3WLPA==
X-Gm-Message-State: AOJu0YwlmP6glWOfv9S4n5V1uXBQBd+R8nou0Qj+oW39VHpo71QtNsLh
	IhjXSO0LPjG9qj7PkpW3uSHkDT0ZRKhX5aeFElssFSDttkkyOVyww3MzFGJkHRQUeWXoGyDHgsn
	wbZo2e8kM6YniNoW86hNFz830z9PySlOy25AeNnFJ
X-Google-Smtp-Source: AGHT+IHlh9lG4DWb0h5SzfU63myWI8aoNkBvMbiWkRAUgDpI8ka+JreWDIaFfCVjmohIyyrEfVAX0hy0xmzJmUxiD6s=
X-Received: by 2002:ac8:5fc2:0:b0:440:62e1:9a75 with SMTP id
 d75a77b69052e-4417aa1773cmr33502851cf.15.1718264512093; Thu, 13 Jun 2024
 00:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613064612.8589-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240613064612.8589-1-krzysztof.kozlowski@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 13 Jun 2024 10:41:39 +0300
Message-ID: <CABjd4Yz9zWPe9nUYhZKMoi1fkSmvOoeT91hCPXjSWfS8fPhynQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: ARM: vt8500: add Alexey and Krzysztof as maintainers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org, 
	soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Krzysztof!

On Thu, Jun 13, 2024 at 9:46=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The ARM VIA/WonderMedia VT8500 platform became orphaned in
> commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
> and clearly it is on the way out of the kernel.  However few folks send
> patches to it and it is nice to actually take them, till the platform is
> in the kernel.
>
> Alexey Charkov still has VT8500 hardware and plans to work on upstream,
> so add Alexey as the maintainer.  Krzysztof will collect patches.
>
> Extend the maintainer entry to cover also VT8500 DTS.
>
> Cc: Alexey Charkov <alchark@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey

