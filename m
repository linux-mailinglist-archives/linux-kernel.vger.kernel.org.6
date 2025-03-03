Return-Path: <linux-kernel+bounces-542637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B8A4CBCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F101887C29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A982233127;
	Mon,  3 Mar 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ky22kxvM"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F31231CB9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029224; cv=none; b=axIrAjyhORcI+xLMIQXr1P/i+ZdtbKV5QxeMiWrzF7kOVErfKNs8bRAQy63P4jkYMkxxgDFMbaIuWvFNdbbQvybeEcKk4gpTrj7uMCvM9m6P7eVUjs/CeDiSlhlYaD60UPyXYayVNoEqjDNnm5EbXaV5Jz0KMLDWXlYAz6SF7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029224; c=relaxed/simple;
	bh=d7VB6lS08b3S7Fc7XUxikf6mYgCNwIZOeiIwVhAxxN8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=juQn0oLL83EwRQqFdfNtUPttWBjToA+lJRexRMnl6f0EYjv7HRBQqnIipp2wSm8JC4E9TvX7AkWkzoo+n6WoWRIWJ/nzHH8JmeFi3QS0qw6cm9Brw21Rmmv/WpgJ0Bn6iMJu7BW/pXmVBHItEcQKFy+VJFvfSTA4eKONZnx87N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ky22kxvM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-474ef1149f3so9277141cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029222; x=1741634022; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0vFdDjI8jMTYO147WtZzJpNLnd44hxb//pKlqmAOrw=;
        b=ky22kxvMSlwLGaP8Ra4BZg7presuQJlxTMmMmOnwlrSROUnzJGzSs8A/jLQojPwKKX
         6nfDjJXyyAB7cpol6QwPf0EYQJnypfm6zDcb0Yw5y7QFT4weL3uIQKCP0eaAaoFvfZWh
         E7ayTzUcY5JW0cyzJaALnoKLntSbfTXb1Ky1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029222; x=1741634022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0vFdDjI8jMTYO147WtZzJpNLnd44hxb//pKlqmAOrw=;
        b=pOQDqlMMVsDx35TxEIcvpvi7xH2paXV7yt7muZKEcAk7EqEJCn9rFvehdY2TItpBqw
         fqc/vF7FWqdaj6fe5WuFE2MKKfIKP0thr0K3f1Doyl2Elx+1cHJFlVQNYhbIljHrskjD
         U6yKX9tKhp9+Kw+gHHRw9Xs3gRZhwV2dAARGLPyNjSdUCoI8rJ6cKewml6pLt+1zDFQZ
         w0Q7UbIJz0y5sWPUqRAA2j+2N7wjbD+2R5O/v82c1sddUzDKYpR3lXIPfbG0+5KZCkci
         A6FkMFk9gCjuKrMoz4HBcsARrGeJz1ZesulKrXGbFCjYZiX2AmiKEfix5pUuvbr0taLj
         Js2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjBNW0jhg+ayXEin5jGmXhH2JlZrvWMkRho//GMbTxF2FYne359KfBxXE4SjS4aLw/TmIilopyt1Hm8ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9J3IWzK/Lvn84Vh6hUElW06WNFEW/ZcH36Aofuyk7dF4TFZpX
	K0LVnSc2UiwS8ZyLpL1jx2sBXip65XmR9/Ot0lV69+CV4izmSDU7iOskhotavA==
X-Gm-Gg: ASbGncvYWWuCIbxYzKF3vDpTahZKif+K++/ypxWN8nsvCAoxM7WbFa8kx21c4RhLWEr
	TarBNKEnajtiHWnrdq8EuRmfCtrhXMd0nGaOwpUSef/dn/+y3P0i8oZlavlbOdADOmi48TrzGy0
	3nCJ5ANxq6sP9ylftpiOA3qGY10PfHdoPhhUj0ocirq82opdditiZLntq+MeUhZ6+9QBqXVALq2
	ceca536zbICJCoG7En51T7Cb1rrMqBm+HNgQUkiCif/gNZYuWrNN7ijKK0XaMhQNHpALc8MOPbi
	2mYXW8FFO9vcpYDtfYieJUC7jXCgCyAksbB3aSYI/TBwo8RhrWOlIN5q14ah15bMqwiIExroNH0
	uXkRrLBYD5rMJ7kzYZqjpuw==
X-Google-Smtp-Source: AGHT+IEBTiLnYhOkJlOJ1keQzIaRvT4aWZ1fued+f3xJt8OT24kf1hQHzklYhUaZzgQ92YhyZ5gZrw==
X-Received: by 2002:a05:622a:1987:b0:467:6563:8b1d with SMTP id d75a77b69052e-474fbc5c607mr4338731cf.6.1741029221862;
        Mon, 03 Mar 2025 11:13:41 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/5] media: uvcvideo: Implement Granular Power Saving
Date: Mon, 03 Mar 2025 19:13:37 +0000
Message-Id: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGH/xWcC/33PTWrDMBAF4KsErasyGv047qr3KFlY0tjWIlaQG
 yXB+O6RDYFQRJdvYL43s7CZUqCZfR0WliiHOcSpBP1xYG7spoF48CUzBFRCoOHX7PiQuukSb5T
 4NHAwrTjqznjVKFbWLon6cN/Jn1PJY5h/Y3rsDVls03+wLDhwIwXaHo1Wrft2Y4rncD1/xjSwz
 cv4MjQgyIqBxbDUK6s1NdY0FUO+G7U7ZDEkevCNBaf9sWKoN6P6i9oMcq2lFgyov8a6rk/lFNo
 ffwEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

Right now we power-up the device when a user open() the device and we
power it off when the last user close() the first video node.

This behaviour affects the power consumption of the device is multiple
use cases, such as:
- Polling the privacy gpio
- udev probing the device

This patchset introduces a more granular power saving behaviour where
the camera is only awaken when needed. It is compatible with
asynchronous controls.

While developing this patchset, two bugs were found. The patchset has
been developed so these fixes can be taken independently.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Improve "media: uvcvideo: Make power management granular" commit
  message.
- Link to v4: https://lore.kernel.org/r/20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org

Changes in v4:
- CodeStyle
- Create uvc_pm_ functions
- Link to v3: https://lore.kernel.org/r/20250206-uvc-granpower-ng-v3-0-32d0d7b0c5d8@chromium.org

Changes in v3:
- Fix build error on sh4.
- Link to v2: https://lore.kernel.org/r/20250203-uvc-granpower-ng-v2-0-bef4b55e7b67@chromium.org

Changes in v2:
- Add missing semicolon.
- Rebase on top of media-committers/next
- Link to v1: https://lore.kernel.org/r/20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: Keep streaming state in the file handle
      media: uvcvideo: Create uvc_pm_(get|put) functions
      media: uvcvideo: Increase/decrease the PM counter per IOCTL
      media: uvcvideo: Make power management granular
      media: uvcvideo: Do not turn on the camera for some ioctls

 drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++-
 drivers/media/usb/uvc/uvc_v4l2.c | 99 ++++++++++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvcvideo.h |  6 +++
 3 files changed, 92 insertions(+), 26 deletions(-)
---
base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
change-id: 20241126-uvc-granpower-ng-069185a6d474

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


