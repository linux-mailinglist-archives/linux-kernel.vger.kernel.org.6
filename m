Return-Path: <linux-kernel+bounces-200312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647908FAE5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF6284106
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C955143893;
	Tue,  4 Jun 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NJU6pIZR"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681D143724
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492152; cv=none; b=s5Z162+dj5DK1M7m0fJ7+oKzMSV9nN9DcTuW0Kf/1jPkEOa0M0z1EnTA/izyKGo89NOruFoUWXJuDYWOKwwYmTHhe+GotX42Dpci0AplfxhQI7oug0fwb+qx9j98LQNlHptyuJnwMs6bice5p6Y03yC0Tc2A9DTioeN0sR7tuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492152; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rytDAaJ7gS1y0U0fHnJJmLfiGR1pk+feFUVJQOXaI+EBNtBuzUB4ye7NSp/IhyQSMPcrYHOqQ3zDETZe50CiKy0FjzM1DWugUPxMVjsHOko5FVc3wfSsVN2G+YqP2gc6eCXW+yadDYMathaoIf3VE+THNVQpAMdgLvpl7RQwaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NJU6pIZR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68cd75b97dso270895166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492148; x=1718096948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=NJU6pIZRF37ypQ1IrVoAhz61ggKsiNb2nDA6S6awqiRYpxWywZ+lvsSoFOmETsAqxW
         MQJ7nHp+4lyg/c97ehJlmrfmUt04lMIzHW55KYR77jv0BwHyjnvvKSnVvBGbjSVmWNmn
         8gLeYbuMZxLEhjVkaLaO4/VncxfSO6DeQqy5vyKTIjYvhtoIku1VnAoc5+tLbbvy+Lc/
         /FPNMKSUKLGbvM7AWLe8nZSJczgHaNJpwzHrTKgzbzy1tsDzzmF9Y06J0kpYXNvgDmV+
         Ojgpw/Jiyx35fllkHZaiRdC2SspsQFtZUqNDFU1Lq8qiZE4LaU5tS13ucPkQXe1+lmsT
         uS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492148; x=1718096948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=jTh6BE3Zf8yNeYjtYJL44+4BMRju7xCt4m4r6RlGSuNBBvHTo5RFe/E1Eannr3udpi
         V87/iBSHUwv26YFauDRNfx7N6NBZRE0/iffp9dr4qKs/Q86QMEj3TnLuPXW8aM7w2uDF
         mUqJLqya7gGhRihtH1PSxwnO8F0HtUv9w1Mhf9nXzRUJcoVCBjIp49IMQt1somMXzcv8
         oeR8x8XCfvGNW+l1vpI8ZamUhiDbcwR/I0oUI2LbGNLAlOcnN+DDVrxBIp3FVt5ivyj3
         WhN3PANRrehncASgyHAQf8f1ZLanfIXbiS5V0TALrzzlVsnKKrrNaHBH9MOaLMsqVvLb
         9iSg==
X-Forwarded-Encrypted: i=1; AJvYcCVawPSkUC5BiHoDP+NU2F7xehtgvSK4mEPOBVdOm1ddWClbGyGC6dm3+me+MLj+70d6oTJMYa1tUgB/vfegON0MoT3otO/MndCYozuw
X-Gm-Message-State: AOJu0YwVeJP5/3woZW+ORH7QEqhRG7Vcir9zFxSc04JgTeqAS4QIssSZ
	srFAYCy9GFocBXMM7SDCHRMw5aRYadV8KnEt2emHyAEjOwBTQBL8ctt5o/5sfeo=
X-Google-Smtp-Source: AGHT+IFF9eijKFo0jcGZn+um4NEghvBvIsaStj/BEJsY3lBQq9sQLzDiRHTklTVApw9KdQGhS/rGUw==
X-Received: by 2002:a17:906:3b47:b0:a68:e429:1d96 with SMTP id a640c23a62f3a-a68e4291f3dmr482446466b.75.1717492148072;
        Tue, 04 Jun 2024 02:09:08 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 02/15] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Tue,  4 Jun 2024 11:08:32 +0200
Message-Id: <20240604090845.2182265-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After eliminating includes of linux/mm.h, the following build failure
occurred:

 ./include/drm/drm_file.h:443:45: warning: ‘struct poll_table_struct’ declared inside parameter list will not be visible outside of this definition or declaration
   443 | __poll_t drm_poll(struct file *filp, struct poll_table_struct *wait);
       |                                             ^~~~~~~~~~~~~~~~~
 In file included from drivers/gpu/drm/imagination/pvr_gem.h:12,
                  from drivers/gpu/drm/imagination/pvr_fw.h:9:
 ./include/drm/drm_gem.h:447:27: error: initialization of ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} from incompatible pointer type ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} [-Werror=incompatible-pointer-types]
   447 |         .poll           = drm_poll,\
       |                           ^~~~~~~~

The compiler is confused, and that can be fixed easily by
forward-declaring the struct expicitly.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/drm/drm_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..f24ade9f766f 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -44,6 +44,7 @@ struct drm_device;
 struct drm_printer;
 struct device;
 struct file;
+struct poll_table_struct;
 
 /*
  * FIXME: Not sure we want to have drm_minor here in the end, but to avoid
-- 
2.39.2


