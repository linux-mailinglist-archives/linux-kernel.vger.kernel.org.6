Return-Path: <linux-kernel+bounces-373955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB849A5FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F14B284402
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399E1D04BB;
	Mon, 21 Oct 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spCXKJ+p"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76591E2859
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502089; cv=none; b=S2nY0t1u0sZBJ65rXoWJLpCN+19vhjUD5fakdqq0V3Cr9499zT2Sl3Axcou8SbwYb7xJFerqWdY/YQRt9jfaydwOHKlGLe0R0QRVdNg53paJAdjypa5QoDo25Ni6uDLG+auzXzQifrG2Bzma8j1xHEpNyMlaPi2BTkETzpIvk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502089; c=relaxed/simple;
	bh=V5T+KifZpNxuES86cc0P0YZbHqO0QvYd0fJIuXHtqjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEkGat3tA7E4BXrmNyGKuqtat1KsfFpL3NAwDYUgmbWW0fhlG1E2IJGJKts9l2WbLnfxd2j3NauCW+d3BnExd+6FfwsyZCQdmq/9ZFAraLNAIQ1fua3uPUGQTAlnZSaTM1f8bGUNjzPlNmfDnvYITan+FaXnyMMtwPyEhwLN1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spCXKJ+p; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso17384415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729502085; x=1730106885; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viIdKZJdxzmzxa+AMbJaVQG5+tOcBpIZMwetXFmiAfI=;
        b=spCXKJ+pLh4Bcii+XX4iSHw3xQJbhEGmKC5zbtgSDy50JRAQZ+i0ERFJ+T0ZzCwJSu
         JnIyCpNZt/Gckso771wI816hJpuU8FRAl18TPWvEAuawNmnyd2DU/Jqzabi6acF2uvCe
         kJUHJPMHKX7KMN2Md5u087+HuVT1QaxWdbX6hcfNhAIAvqIlQ9ELzOPUri8h8/Wse6FP
         W90osZ2vioMrCF3J90MA6/GFKgp/2xdNdXn9ySMdT430nXRhmYPkM/EAyNXvxRTQ9yEU
         xwCOUtr+uZUjMNAnPtkvsSpox6Zz5IZAZDPD1wh5BS0qNSufJhAVj+BiJoz0M/ziNkJ5
         xtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502085; x=1730106885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viIdKZJdxzmzxa+AMbJaVQG5+tOcBpIZMwetXFmiAfI=;
        b=CunyHWllZ1aKs6YOxOzXKh029jX5LAJQcWEJAtDIGe+r+PHzMjdYltgCA6F8h9f0eA
         DUXU5UsFeUnu9JoUet6h4fD7EyHX64d/PxnAM1FX+gsjwAolD6Y3ieJy+rW7GN1cnxq2
         Hy/r1ZW8UBEyh4vCuDpXRECOfdigsEnfI//1IHtVWsE9NhMRp7Lex1IEs+qgGYR1EEvb
         8XZEVYOquc2aSh9i/ayW/BrYl72rTYxER0jSpHKf5cFxa1ObQtEapm0RmGmDkm/E7APH
         6pjooeJTBEjz+bgKuArlw7mF0rtQZPh8sTnnggtGayVY3aXgC6Qhsw4DEZOKAB0dU8aT
         27cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg2eawQLUMLB97TZCHjK9cj722eJZJKvt63hlvmwqUiGxrzCfBjU9/YKThhwlyFPStoqOLr5yx0UqbqrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBUeh+Sl1jmvZEhrcMJQ4mbQikUBDAqwsp6VT/efYLPJdbzAs
	2LQ2jmVnDWmceQQdPNSl2AaFRt+Xrta1FQ2WU5RCyOmvHwjlRNU1mXKx8rQRiYI=
X-Google-Smtp-Source: AGHT+IHRJ3XMQNNFSL+N9qTIsbeBkdqtT90O1Pz3aDqarzu2Bt0GMkFFH7O+TI0+CrOjEzrpheLyBA==
X-Received: by 2002:a05:600c:510f:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-43161631435mr80440425e9.10.1729502085149;
        Mon, 21 Oct 2024 02:14:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cb88csm50401685e9.39.2024.10.21.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:14:44 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:14:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Message-ID: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We need to call mutex_unlock() on this error path.

Fixes: aad0394e7a02 ("wifi: rtw89: tweak driver architecture for impending MLO support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ee63a85308f..565347a6e1e6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
+		mutex_unlock(&rtwdev->mutex);
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
-- 
2.45.2


