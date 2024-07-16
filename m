Return-Path: <linux-kernel+bounces-253257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB27931EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0DEB21CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A3563C7;
	Tue, 16 Jul 2024 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WZTrapg3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8F101D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096336; cv=none; b=ubqqRx0sMw0J5Sj60pacxrSVWh11nm36+AE9uF9uGFzwCXn1iNgttYijAoL0pov4JlcGA8zErFEtqjCW3U3SWBH42rHg/DMGkxL2UzOZovcaBNKLq6WE7wM5ONtLRyp/i9fvMs1NkDvFhIIffQM6zmjS+yiVw1x5BKAq039Dx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096336; c=relaxed/simple;
	bh=pyKsuwqVIboN9EwThCz5EI7HZB3JIVS86qz5vkpAtLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXXTqZq94gFWqKZ1JaxhiCq2FwSINZSMBRas8ofY+JZttZYXBuSL9pU2cyOQOho8yjI0g6KAzuwKMd7q0nvBYEQPyqpq1I9IRMi5SOdL4XTaCk77NBdHRcWOBAeYYsWiXZmKWJIsA/EbnCXKTtRY6o2MUVXto1auHkN+k9yr5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WZTrapg3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e98087e32so5908380e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721096332; x=1721701132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+l4WKIaaq5577Hbze0C2fWBRy2R2qvbUGhdaCCzWQY=;
        b=WZTrapg34Dbp03FU43bq4kj6Hx51l/zqXX0MqKNRp+56sBM8tI86sPnvKraGXehBLQ
         D+XqCv6PKvqYPzff/SEPWzrXFlwm4OXso3TlSF4NbFYATJN5hgPOFfCSYFJ0go8U76Nj
         ZWlnu+JvimAQywFcBRc5ijuGaPNKgpQ+vPRcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096332; x=1721701132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+l4WKIaaq5577Hbze0C2fWBRy2R2qvbUGhdaCCzWQY=;
        b=UU/KEmNul9vgQqI4mDga1LMeoTG1qPUoJI1OXwSfPg+XX44y2aVpMakfIhhRx69m6V
         TCatdXx2WSmnsu7KJB/Julw34l30bXRjYV4pbLp1ItZhTCn3s0c2kCyvjk6denq8Xsej
         UCTRnc7R0wiBPf1E+iwYapuZ2EZpsEG6xpEHkmyWqyoxVTJ5ixMxkksm6y4XfJsHaHZY
         RNzuFe6FTDn7PRCMoS60wi31g2umLJ63fOJ5x7z4DGlAvukNIPTdKPrIJYa8/72lyWzd
         36euhKSqx/oq4l++m4IJr394+jp1tbE0KfrJPYZCAZwf0Zm0N0xC3m+PZJN+6Uxv0bI6
         BfiA==
X-Forwarded-Encrypted: i=1; AJvYcCWq5sXZ0ugjVcNUASSI4gEEylbLijh85akS6Ke7vqYRNnoCWmGjH5myyucSi/h/2f90rBwpoVtNT2KzDg9x0pp+RDI9Z91oH2SydUdo
X-Gm-Message-State: AOJu0YyBuN06WAQNNPyrD1KYP20TXz3CV/Uq1mj+cPn3t60k8gYgLar/
	1VcP2/0u8jzD/AekjHgUpDtrfOHiJx1YFDRDI4W0i4x2wPF6AeoC2mTlOtk9YLGUHRR5Vq3u4m2
	s9EE=
X-Google-Smtp-Source: AGHT+IGNBETc3k3x9o2OG9UMhfH+odTqseTnn8kWcvaZaYQvL3P41K+m5RiKYOJdhnU09wC49mBKFA==
X-Received: by 2002:a05:6512:1095:b0:52b:bd97:ffdc with SMTP id 2adb3069b0e04-52edf030a8fmr366267e87.59.1721096332605;
        Mon, 15 Jul 2024 19:18:52 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed25484e7sm1019605e87.302.2024.07.15.19.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:18:51 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea2f58448so6630050e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR/jHiTUxCcdDRk2xKCKfnuWlVwX44/CsgLj5fObESieipcMnMIG5/nMDcJJRTrChCBHEJHvqswOH08Q/T40Lh/T6jbrkmZccXnp8E
X-Received: by 2002:a05:6512:280d:b0:52e:9905:eb98 with SMTP id
 2adb3069b0e04-52edf018688mr350932e87.35.1721096330887; Mon, 15 Jul 2024
 19:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl> <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 19:18:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiVHdEX5i5kuNLewy9OUvYaWX_DYiRmOS1Fcj1pJ+QPQ@mail.gmail.com>
Message-ID: <CAHk-=wgiVHdEX5i5kuNLewy9OUvYaWX_DYiRmOS1Fcj1pJ+QPQ@mail.gmail.com>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 19:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But asking *twice* is definitely not kosher.

.. and obviously it's only "twice" right now.

If every driver continues this pattern, we'll have "n+1" questions.

        Linus

