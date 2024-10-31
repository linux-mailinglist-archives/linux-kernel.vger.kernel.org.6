Return-Path: <linux-kernel+bounces-390497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B99B7A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB04281BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1D19C562;
	Thu, 31 Oct 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U0iHJF39"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFE187864
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378067; cv=none; b=ko1gRskQ+g+a85wYfaMHBuVpaPLRqhlbCti3sYITvZTs2QYkURoCxEj9YZ7X4rfgGjJMLfdNz3jDT+B/n17eIVlN2Hhv6z0mKZDypPpfV7tYT38gK/mCq9FfjL85hik25fYalVaEMzoUiJkbXvtECY70pJhT4X4dZcTwzeD9Bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378067; c=relaxed/simple;
	bh=m48n008ctBtYqrvJex1KITkek7KCiQquXwKklYAXLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUuj0OYTXNvcoopZYxAYKvV2EMf4a90fLxtpMmbm7ljV8tPPQHJRLtxkT0d5nK2/xN3QO9anO4ZvQeQQgshXcy4iX5MEzYcptj4Zh0pW1tbe4WoTb2Gh37fgEEKOQiGVVr3xsBXg1SGy50L+cPGc5NKG2NGLO5lH4UlKdCR+aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U0iHJF39; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so7659115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378064; x=1730982864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzl3Xa9C7yODRffDmu7ydBj4yLwByepcumnubkJz5KE=;
        b=U0iHJF39Y0H8ZkUEbxZ73rNqxpMIj4sWkjcLpwhRmYrf5uyPV92nYiMZKvleCanWje
         NWd0u9sldlktIXDRYfPRIVkRhVxnuBhUerOaNtaYQAWbFTZSXiLivW341nXd9IZS/G+7
         osvh7Kbf5zWORj462DuCF68sX1UpMkpfzfOgeqUFfNTZfr9BW4RLUfaXpxd29b/+s5lM
         oaduGNkPQl8ZKWkbyacKajLHMLRC74oCE9afVbXGZFMuC/7kVta4ni4DwkNhAUKtpyPB
         IcL+Dit7j9qDNUOA3+eDcKPTGPOqk3/lLg41RhUAZA3wDbBSj+aofa3AR9YzVoLKRKzG
         9CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378064; x=1730982864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzl3Xa9C7yODRffDmu7ydBj4yLwByepcumnubkJz5KE=;
        b=FqjFZNZ7OhMmuXmX+Bu5iLa/Vh81s/CLCb2wmw1aOrf+BkqU0Tsh1pk69o12USR/E7
         fN8EDtZyaVsVzEtk+3560pD+B/lLBGLYi6TQkRm/0Lo6wiDlI2dFaLljE9CGw2nOR6+8
         Ez1f7JrM48AONKKIj32XweEzSgQ5gMWTHRbQRILyxSUhCjrUJ5UA9d3nkLbzyxEsB7z2
         FSs3wQUmzfrIbZsyb5cgt8YtAMRbdUyK5fkfFucpkOw0ogZShPI6qeNVBKwwZmsSCu0r
         icjaokDd0BoJXV5pjIbLM/DVm1iJM1/HHP0C043ld+5QOWCTLAR7EJ/XiJW9gSRGE24u
         +MXA==
X-Forwarded-Encrypted: i=1; AJvYcCUMaGkmtYJhVnXQaiUbyXCLXxo+BHb0hTCZI7Jb7eRNqAaIRBswyugy/s+HpkYRQY0aVmRwi67hvZwVsJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhk8j7py7lEq5CkS+WMo93HRz6b3hwii1lZ39gzWHc2KtBt/a
	WiYNkjQv29z3Z4xkD5ctDJIVfPPFBsrCDxi4JNMtCsBt2qy/j4G5qg+lI0GUK4M=
X-Google-Smtp-Source: AGHT+IEEO7DvzSltFuSOOW7tGilfwME6cwZASRB5gd9U1RoN4BL+MSsBkr+M1gSe6V2EUA3IAfJTCg==
X-Received: by 2002:a05:600c:548a:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4319ac9c555mr173232775e9.10.1730378064138;
        Thu, 31 Oct 2024 05:34:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5abfefsm24871935e9.4.2024.10.31.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:34:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sysfs: demote warning messages on invalid user input to debug
Date: Thu, 31 Oct 2024 13:34:21 +0100
Message-ID: <173037805747.6410.14300588256259138318.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021185717.96449-1-brgl@bgdev.pl>
References: <20241021185717.96449-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 21 Oct 2024 20:57:17 +0200, Bartosz Golaszewski wrote:
> We should not emit a non-ratelimited warning everytime a user passes an
> invalid value to /sys/class/gpio/export as it's an easy way to spam the
> kernel log. Change the relevant messages to pr_debug_ratelimited().
> 
> 

Applied, thanks!

[1/1] gpio: sysfs: demote warning messages on invalid user input to debug
      commit: 37d5a6d6f406322ed0850fc2af1d377aced16340

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

