Return-Path: <linux-kernel+bounces-375775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1049A9AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA60F1F24A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038281494A6;
	Tue, 22 Oct 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xsBfgaHr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BD1487D1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581238; cv=none; b=nA06zt90BEtOWJw4qMgCbjcNSZBio3ojcxU48QBuYq4rEb1UwPrndfXvXXDYW1UPF3NY34ndXYZj10aHC+eh0F9Jd0TLQNShiWQEtFgr9zNzLg87RZeCBTg6FbqoyPlNn79r096RvjoIWm7hN0NqYcIJjTch4coGl4mdweHBtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581238; c=relaxed/simple;
	bh=M68uSLnvJSaWRdyBgND1P3SC445qvbbnOOZ+7soi7SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShYNDAsIQhjQ9W84y+hvcWqkYtgE39DYGQQL+HTa2b0Xn6xYbyIztdrLVNp3Xs2j91Wiqk7FBWCIFzpz/qRzzANcnERwAFGYfqcoN+bh/uMW2P0EUTCqOzQg9chds3sSyW7RrI8Ue08ytbH/ThUUtNw7dUUcBi/a9r/JDtnVk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xsBfgaHr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d461162b8so3526248f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729581235; x=1730186035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu7/6biP0r///L+Czeg5+6U/oTA7jDzuwpELtMKnMrs=;
        b=xsBfgaHroHXg70Zj+Sn+drSXOqltVcIqDMr1YvBT7ovcJEXjsp856nMU3CvMqJVRTp
         ZxTnAcKPAET32708QJmN6CDBeZnxdZHJBCzmN2PVMm4mUrwBLrtBSnLLJ+xXKlo7CZUF
         L5TawfIAog03yC9QYG5TYjnFlKANiIfBJOFH/+VUt6c2NbRhP8OT3/uaupU8UJss9Ikl
         qCcPX58WUtOru5NMlkh+rF/vSdK9qB5sXvk/iT2R/Ij+PdCVvLbjxxshemRNF5ZIMecG
         nmtOsIoiripfpmZ+HYlFCs8bZjXgzQ2am6vT0wWIuEdBxPwLqKEIW5A0/P53YE853ual
         0rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581235; x=1730186035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu7/6biP0r///L+Czeg5+6U/oTA7jDzuwpELtMKnMrs=;
        b=w1QBSkApXXccz2nIuJ04iS+g1D84GMkG8PLwbEaytrTNd2gixyWT7pG7txv8luUdhy
         1AwdmP+0h2QYCAnIJFqhbcFXYXYH7kwEh+DMGSzXNNBEelKwxoif/aGdEA6cB8HVqL7u
         58ran9B0/FBarhobXlLhAu3e7wUkNeRHgP851BqCyhoplTPe2MSjURUN5hmWxeHtgW+i
         DPuxXZ7L329lIyWEWpD+lhzIoOVJdBA3HVx0j3JIpjKx7ShTE9e4TpxEtrSqQG08LxB2
         4R3oXgeebwR7631KPuSky3qB8Q3SoRS+bEJTrsFEh5eEqEqCe2qJs2rGKIuZNSLnBO2Y
         eJbw==
X-Forwarded-Encrypted: i=1; AJvYcCVULHlFR+vsZFVSyEozc6AiRKNM9zm3Ufwq+c9hwq0l+YGQVWLl9VuIzGAwTJoAH0+0htAlyJh+upwRd8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y70nCUwRMQjbkPtdOlJcqS2J8cMQq72lxlKkkNEiKLoz7syy
	y39uwS97UUUPTWrJMV0HhP0ROhB+o7p07wKrGxA2nqxTroJoAK88DM3dqWPLgRg=
X-Google-Smtp-Source: AGHT+IEsABVAJqJe/8IcrnXKLJC1wZG/HV5NwbiM9/5GqjkeVIBM90CoxKU2R4T3WOtPIV0inuCfvg==
X-Received: by 2002:a5d:5e10:0:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-37ed2b7afc9mr7498252f8f.8.1729581234903;
        Tue, 22 Oct 2024 00:13:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9c8b:c7e5:66f5:b8f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ae36sm5955801f8f.43.2024.10.22.00.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:13:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add a keyword entry for the GPIO subsystem
Date: Tue, 22 Oct 2024 09:13:51 +0200
Message-ID: <172958121345.18422.7642446863562220364.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017071835.19069-1-brgl@bgdev.pl>
References: <20241017071835.19069-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 17 Oct 2024 09:18:35 +0200, Bartosz Golaszewski wrote:
> Every now and then - despite being clearly documented as deprecated -
> the legacy GPIO API is being used in some new drivers in the kernel. Add
> a keyword pattern matching the unwanted functions so that I get Cc'ed
> anytime they're being used and get the chance to object.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: add a keyword entry for the GPIO subsystem
      commit: 7e336a6c15ec7675adc1b376ca176ab013642098

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

