Return-Path: <linux-kernel+bounces-247576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99A92D168
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE642826E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C21922F7;
	Wed, 10 Jul 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j0dMtNAf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA4189F26
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613886; cv=none; b=KPY862oI5veIo1bBN9fhWqGjK90EJUeZ0lPHAVtWvwf9tbuaVlsODOBAiu7wAfRG4uVVqr8zDsVV1Qv7dbfREVFyGRkJoD+Xp/nxPq5CofnrxBhbc58UcMrYdRCGMv9M0OedbG+HV2fP+VnXH67e0dBFBtTUFqL/lsIJkdYHEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613886; c=relaxed/simple;
	bh=FKo/K1VSevgT1kqfr6Wf2OJjV9CNzfKMHv6LZyf57Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnnUHVnS4/HptxFNw3Fx7jZG/cteMKsfZB3O6v4b4UzIT+1IbKX/jKnfQqnB0vTcl8voDETgOtFJYJ5iUOM8p9fyrkFXHU/mT9LXgcpIMToFE7rX3D/H3d2DJbl9ocapkBxP08R1NA3yNE/OIicVMFsA/W1Jbg/7RZ0Gbp9Sc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j0dMtNAf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso2544293f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720613884; x=1721218684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/8pMMHSXBlTGnflwKPolD6eXWXrrXR5fKDvq9SAPrE=;
        b=j0dMtNAfhcmRPGpo2f1j+eFJD3JVbytfZIWLtowVWiJAT/Qaw8bweW0B5dz6vwWxiA
         1/AQ78xydPT0R97KOBOYdiN7CuBlEEmiZBK3DhFHxzhyaAirSlIhVyBPUMKVflacOPrw
         eQ0dpZQt9VA651r6jvMIQ/nzpO8nwIEP8weBfzJSxaIdI0oZwFINO2T8tHjHKp1sd9dN
         ptYxWuHCUzw401DEl6MdH4oysvCkAMhP5MQqk24VEj7cZvXBtnsYEjYyvQFtrMSE9Uy8
         313iq0lslQ4qkoeRbsoiWmmS2lwY3H5feCSHxo58PBgUwRSCHlDE9BTM2yM8bolsMw8f
         1quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720613884; x=1721218684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/8pMMHSXBlTGnflwKPolD6eXWXrrXR5fKDvq9SAPrE=;
        b=FibO6sg9/OQ8g9jdYJC8OM5beYs2b1t1F480QdABP0O7XtAImIuBusE2+n0JwElZcZ
         wwYelwrjKgR/iNJoH2MNsqKOMhT2Tbr/9qJwpsr0qg0EPMUA7OJjqAOfCa0eHn8P/OOi
         lUw7ZGGaMkf1wwW9+kYnnHmaxvUH+uc5QjETEey4vO9KDVlSCb8/pnlqLZXXgKQz2Zdd
         UntGg8Y9pU6uohdnO1kEBZo/qSK0lZYJcFs6nhaaGeb86R9NO5JcfJ2XmCmSSt6MK2cH
         IK8tpStitgsHoGlI0g1a8t2Ndx7KxEEpUoFeVBaPyqhbtECkoo05g38SJE4iLzLN9fHF
         HVFA==
X-Forwarded-Encrypted: i=1; AJvYcCUnTsBW4drb8QEzS4MO6ND99OH3+jBpE5AlBa40DhkQxBSuCwQM26vSg/A8g59DnIrHPhz8TJpke+Kp9GkctLsW2gBWgM9WmsxYtB4z
X-Gm-Message-State: AOJu0YxkXm7buxpiAKBUu7p0z2SpsErbk5GELp7wDm4lKrUhIEMzDHB8
	WpnYr37eSDa6oVPOUAovSsU3putlfdJKpOI63XhpxDKC5sZ0hBm0teU7IYK+jtM=
X-Google-Smtp-Source: AGHT+IHk3Oe2Tphyw/knDnElbIxyRbcJCQCAlp4hzYadpjISwaJU8fcvfIPj0dweiTCIu6/Xt7QmVw==
X-Received: by 2002:a5d:4349:0:b0:360:89a3:5293 with SMTP id ffacd0b85a97d-367ce5df8c1mr3229870f8f.0.1720613883651;
        Wed, 10 Jul 2024 05:18:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5d33:75a6:b07c:5579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84798sm5160571f8f.38.2024.07.10.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:18:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: virtuser: actually use the "trimmed" local variable
Date: Wed, 10 Jul 2024 14:18:01 +0200
Message-ID: <172061387941.25630.17691925679100572305.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709151235.90523-1-brgl@bgdev.pl>
References: <20240709151235.90523-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 09 Jul 2024 17:12:34 +0200, Bartosz Golaszewski wrote:
> This variable is set with the intention of being passed to the
> subsequent strcmp() but something went wrong and it was left unused. Use
> it now.
> 
> 

Applied, thanks!

[1/1] gpio: virtuser: actually use the "trimmed" local variable
      commit: 1d8267bcbb7aa2176365299ad57e067f73b5174d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

