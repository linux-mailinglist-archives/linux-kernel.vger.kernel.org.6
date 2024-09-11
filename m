Return-Path: <linux-kernel+bounces-324228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638A9749AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DA01C25331
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D346F2FD;
	Wed, 11 Sep 2024 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0fhHeX3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5B5680;
	Wed, 11 Sep 2024 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031947; cv=none; b=TYQAsYx+zZNwiluQpgvczG8gCLWWgmymzLUgV65CMK8516laAeWdbmxXdZxeMk+lr7Oc51Z6NZvzlWrjw9QL7VE9stF1tSUAxjp9G26+Zn3ZH6JyNi+k13l1FaVBRRPIOFwezNhN4PyeY7QwnSHhMPNTibtiTVChOk9zFzLk6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031947; c=relaxed/simple;
	bh=unXxna7n/7rQalTgAPNaAlNsd1AAw2uCgz0W+HRJtRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAzny3TzactZCeqPI2tdtjDjQCSaV6D2TH8506j9yUHt3PltW9h/4LsVOf1B2UbnxKU0yTzzVVciz8I30859WLT3H4chbphPIUSQm9yOWatI1pKp5iHELJbIkfW+yFHJQ3DEBCGB75UoFjcpUl5AVlCYAmfM9roVcygKrTvnqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0fhHeX3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20688fbaeafso64945015ad.0;
        Tue, 10 Sep 2024 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031945; x=1726636745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGecZtNlYRGSVUVbzd9Cc7GxeUDF7uiSFa5DLwCliL8=;
        b=m0fhHeX3VrDeTyFi+MQOfSnLVtyoA35TPikspdlY+/R+bkh8zK5Rh14AD6ytEHgTVD
         wYYEu/t1ANTU5BhAF/1Y4L7m13wvbAxa2GChb9OQm4Nh0fzBCzyGf69ndAVXhGfFYlS2
         DWeUJx0BAEFxlYX8n1CViDXpZNZCYmiYg/wqzMX8FefOTC3MB/UL5K6QZxrQCwkAIQa6
         r2erJCn9JjqWJewtlpj5Prw5sqQumz3WVkn2m2CzCXFCqo62YXymFXlzKXwFs3yPMpYs
         XhRVhcAxOuUIJQjj+aUY1AmkTbgg5KwjWEHxZNKXjLS2HNoIkzPVon9O6y2C4LxYrQu0
         j1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031945; x=1726636745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGecZtNlYRGSVUVbzd9Cc7GxeUDF7uiSFa5DLwCliL8=;
        b=qBlsf0B+ulMYJ/mjeoC8G7OkgQPafchcmCC6TQ7vnVCC+/5q1tBvt3VAWrLbatd965
         X7bdCzwuivO7H9OeJbbEbElCQCZN7La8SZVxBt0uaamRw0M5oBgo7QRb5K3BnL+dZs98
         hqSyRBMLuJsvIiNpxNqSBIPVwaO6xRuAZYJ5lhBUK88llW/Cexz06mP3vI7ncm7yDh8f
         bpOtDF3UP8vQBd+I8M2xY7QJa9kEu79Fwr/FX3tYvEwhpAB/fXrIVlPNcJBSAQxCMK0C
         yMq9OHSFitFlt4ym9cJVrdRo80H1E6rTvcTgM8CADthBmm49ACxAUKAEf2Lx+3XgB7pE
         J73Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkpQmrfWOXoqigR/LIASKEThUS2qMkL7+oqawm9+2qbOq9pdS6G+2ZSjiLDe1+hsoc/qEGzh0/rheYDP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEwb3xz6MHcILtvDk9TPpE+S+wnuGdCh4MQAxtp3Alu7M9kIC
	GwiOIpbwDPvhTNjR+1bi5kGHtA1zsrtGj/4WGI4/+R2vxui+ow34
X-Google-Smtp-Source: AGHT+IF7sh7PQJ+mMvZHlU738whKU93cwnPY+FnPLoTLffKuxT1kmXE4a63N9/nNTB4CUdlm+nhIyQ==
X-Received: by 2002:a17:903:22cc:b0:205:809c:d490 with SMTP id d9443c01a7336-2074c5e6165mr49312895ad.16.1726031945051;
        Tue, 10 Sep 2024 22:19:05 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10eb4sm56252735ad.7.2024.09.10.22.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:19:04 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH 0/3] xhci: Some improvement for Etron xHCI host
Date: Wed, 11 Sep 2024 13:17:16 +0800
Message-Id: <20240911051716.6572-4-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911051716.6572-1-ki.chiang65@gmail.com>
References: <20240911051716.6572-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new quirks XHCI_NO_RESET_DEVICE/XHCI_NO_BREAK_CTRL_TD to
invoke the workaround:
 xhci: Don't issue Reset Device command to Etron xHCI host
 xhci: Fix control transfer error on Etron xHCI host

Apply quirk XHCI_NO_SOFT_RETRY to disable Soft Retry:
 xhci: Don't perform Soft Retry for Etron xHCI host

Kuangyi Chiang (3):
  xhci: Don't issue Reset Device command to Etron xHCI host
  xhci: Fix control transfer error on Etron xHCI host
  xhci: Don't perform Soft Retry for Etron xHCI host

 drivers/usb/host/xhci-pci.c  |  6 ++++++
 drivers/usb/host/xhci-ring.c | 13 +++++++++++++
 drivers/usb/host/xhci.c      | 19 +++++++++++++++++++
 drivers/usb/host/xhci.h      |  2 ++
 4 files changed, 40 insertions(+)

-- 
2.25.1


