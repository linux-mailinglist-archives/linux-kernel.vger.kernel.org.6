Return-Path: <linux-kernel+bounces-367580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2389A0415
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6741B270E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458341BBBC8;
	Wed, 16 Oct 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdYb5II8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F801BB6A0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066873; cv=none; b=n4lSygJAPSlUyakqgWF9Kdr2td4BpKVzPwWO6SI9WHxvoFBVZ3zd/oYuCdDOrUEGGJA0/uw9qrKwVbZDlCjLJHQ5x8Ojhgrzxct5HEzx5cKcWfZWkLhvM1Vh5BRHDZtt5jGLYbS9X4ilJ7uvh0KY4e31iR39FKkCzrS5NBVmG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066873; c=relaxed/simple;
	bh=UzSOWuHbZ5Ol08JLBsywiLxpxtXJWiUM0Bw5vEAdwUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RMeGDwfmybG4Uy6AB8Gkq6xLlYIGh/Tn05t3nqXx0o92qPR6t2oF/DpO10Qc8GpqzqwLSZTwoAGfE6MtZsVaDyDcParTtoqKrdJ5hEGVc494KABguqRORDTbvqaMmJXuce2sKaCY8ghs/7akqLYJTGUw71LpRAYSsMZRVorW9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JdYb5II8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311420b675so57769125e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729066870; x=1729671670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHuHA10oz+IlUb3WFI3EHpjMKwYEau3D3WrIjZr3cMQ=;
        b=JdYb5II8Li6JU3BDEJInlG8siyHpud1BLRxGSUF1QSEADszs/qNtNEknMGxJn90PBX
         7LIdZa2ZpjtS1QBh5yN+I8ghTw9z3JA1x4fW6ZSxj01T75qlxIfHWwObSl4xmlCTcutn
         3HoXcHLrI9op9zpPPLqJKFVg9JXKvlKfq9fi6BLBJchabkihGivEN/o93/XnGgHWCPYD
         uIHI61blUCV/sw2wbsnP1dtvGE5Jk7fP+pxYIVFTSI9cTCxoENFDxm51w64EtrhJYVU9
         XgNT2puBIm4KSlLheE3v5XbLq3R4CLLP+w+tMnIUJnE3GsSPbAkXHD6taW2qih0UN9iC
         Zvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066870; x=1729671670;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHuHA10oz+IlUb3WFI3EHpjMKwYEau3D3WrIjZr3cMQ=;
        b=QDX26YDRiT7oW6J38DUwIy2s8yd8xhwAar1TBkeq+ra2dGoAF+9ooKAs39nVMyP0hw
         N3nIQ5ysSssjcrDsHJzGFb9AOjheQyrfn7uK5u7c5HhGFOat4iLkZd7R9tWL84KK7a4E
         FW9DlvAyj9rpG9kuMTC5rGgh9IOY0ljzgYfAFRmzIqzDN7qxwA5rDil+sGN8DzyHRFRH
         YmDFsRrAdlvwJpuC4KnbwAcmze9CEIwVBy7LKkC8k0H3J5hYw7YMLG3LoXfpgLFZ87j5
         qLvGEKXROlv5FyVr99zbxqcDgzCOIWGNHCwJGkag8QidyIJW0Goewp/nr215UEcUADpM
         3EPA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+HiQx7V9W6ni2r9v6mh4fCVqZrcamSX43uPMNFxIYc3mzlKmtfVkrglx4B6EHkqHgYZ+1DSopLkqdoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkdrr3I1CyFRuicBSeKQccW859Ho3I5zvML771aUvjZewUqhFg
	4NYRywGiA1t3prUEsSiCXcBv2LH1xlVMMhu7TijSZyn3+z36Uvp8tnMPlDp5m4i4QxOxCuNE3zC
	X5co=
X-Google-Smtp-Source: AGHT+IERLNsDKzULbD6b+VfFRVUqsn5sE8FD5wfQhGK0Pm7Idfsgba53RSTr8weraZ+y4cAyzf8GLQ==
X-Received: by 2002:a05:600c:4f83:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-4314a322492mr24798595e9.19.1729066870226;
        Wed, 16 Oct 2024 01:21:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f569eacsm41658965e9.20.2024.10.16.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:21:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Danila Tikhonov <danila@jiaxyga.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@mainlining.org
In-Reply-To: <20241013212402.15624-1-danila@jiaxyga.com>
References: <20241013212402.15624-1-danila@jiaxyga.com>
Subject: Re: [PATCH 0/2] Add Samsung AMS581VF01 panel support
Message-Id: <172906686939.3993974.10769227098345025810.b4-ty@linaro.org>
Date: Wed, 16 Oct 2024 10:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Mon, 14 Oct 2024 00:24:00 +0300, Danila Tikhonov wrote:
> This patch series adds support for the Samsung AMS581VF01 panel, used in
> the Google Pixel 4a (sm7150-google-sunfish). Unlike many other devices,
> which may use different panels in various revisions, the Pixel 4a has only
> one possible panel option. Also this panel is not used in other devices.
> Testing has been done by me.
> 
> The driver initializes the panel in normal mode (High Brightness Mode and
> Brightness Dimming are disabled). High Brightness Mode and Brightness
> Dimming are not supported yet.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Samsung AMS581VF01
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dca22e99706b70169534575fc82028bb6d44138a
[2/2] drm/panel: Add Samsung AMS581VF01 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b330f3a069a20a5698ac840908579c325b7bdc4a

-- 
Neil


