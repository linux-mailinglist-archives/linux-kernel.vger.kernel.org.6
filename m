Return-Path: <linux-kernel+bounces-182789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEB8C8FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC421F22706
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AFC1094E;
	Sat, 18 May 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKElO2MP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AED53B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716017086; cv=none; b=qW+1R7Ro1fl3T4mKmeHYh86F0ofNPNlOJOOud884QjhFq3Sk0S9gJ0B6ZhQ0TU+oMCWAx6GYT3kxZoahApA562XELr9afSnsVbbUz5oM64OmFc1nPn62NkacfOqJAqaGUL4tv4LAWsIT26lZ/x/hc/a6tuemkDmgBjfFvkNtWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716017086; c=relaxed/simple;
	bh=a3XvBXPOApY3RRFgdOHOwQDdLJuSEV/tLdbjK+TjgbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbA1cJ6l2xTWl3eYFFbGAOGNrkrnlc2ABLGW5SZsQ6dqFrzbJVqA/l6o3xZhsDLbAxMuwWoZJFRlgZY04ajmPjShoi084Cvjrkqyf7CmHZ0ZyICA5JMA0t4xfIGoOKJvqmo7cOrA9VaoELgSZGQb91ykyyoB+nsW7B40sjRU+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKElO2MP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-622ccd54631so123384637b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716017084; x=1716621884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4IQYxb+uDF+mWfJsVcG+5UtKWGYyO2JjMy9dD17Z8=;
        b=UKElO2MPo6JzXv1OmDDLIvJ0CuZv/IF4ov3RTAq6QZwvpVGUTmfz+/Zb43U3i04Y6Z
         GlPSFdStZut96pfWt255XgvI8IBB+OJQsi2uh2tOLFyjPkmoAFiq8LNaHCra11cgNsMY
         2cSmKpl/vscbzEXRGT+evaJE9oedtoWh1KAx76Ex6fUnvDEx4dl7i4Mdq/GqzW2yHbC/
         lilABnmRCZRu/D1MchuQCTJuJED8hKahSlrHu50coOEoQxJ2UR2xDcKoy20sR88SH+Ci
         E2Lyq8JNL6VqmAvtTmzKB73IkYauEPIkSEMfERF2M9ixUkk+LR/ESJZgF8o9ea9DP4wp
         kdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716017084; x=1716621884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4IQYxb+uDF+mWfJsVcG+5UtKWGYyO2JjMy9dD17Z8=;
        b=iaoNi+lhnI9Hcd+t9dYWqy37E37a938pli5uwPQg79HpPGPst+mjS8b+/kEfvrA+v0
         4wckFc8R7/zWeCP/25YlqD3JTnAfdSYlFsmp88JR4kuLFs5D42zwG+j8OeHeBxTzwmsR
         /tYHvBTdWXCq4Kkp5nS0qvAUJsRpN44U3f4Xah6ISNFVPDNoJ/vdjtcY2z292x/1k19x
         vltcLS0p5l0VW1U0ERXboT/qOM/peUQ7ApK41JagUuFupJL7JNUgfjQz4OwAbt8ZFE56
         T4CjToTsPEipvfxH5zKp8/3w80cqmbhzimIc8stgmC5ISm3Kvp7LJB/uOj/35fkNfGrw
         I1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoQrAjIZnCTMXfOCYkyqlTFRp4W1jm+U8b0KAhkqfHnZGNsb/4KNY7P9Tp0RCmaRjnV9xb0ZuiEuygwGx1Sbq2fsboTjEt+RA1RQog
X-Gm-Message-State: AOJu0YyJy0bhGRrCAJgBHVXJrnkqpAm3QlRiddMT2zjHupZyb44iWjBK
	d35i1mlJaNMsX2DbmX3Dq7lcU0TGOjGl9T72u9xrnkFehXEp0naFpjtUeuGmZAAFIHgHOOJZc3/
	33xRx0g==
X-Google-Smtp-Source: AGHT+IE94WyeH6RLcAAIOJcTGdhrJI64gxY6uGfhyG5sUnknlOWcMCOVqt5FlhysOWO0+Z0nlFbjELjLHqB7
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:97d6:5b37:f65f:971e])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:1082:b0:de5:a1c9:7a7a with SMTP
 id 3f1490d57ef6-dee4f1903fdmr1751333276.4.1716017083829; Sat, 18 May 2024
 00:24:43 -0700 (PDT)
Date: Sat, 18 May 2024 00:24:22 -0700
In-Reply-To: <20240518072422.771698-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518072422.771698-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240518072422.771698-2-yuanchu@google.com>
Subject: [PATCH v1 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org, 
	Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fdc3b09c171..fd77ce0c1328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18048,6 +18048,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


