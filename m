Return-Path: <linux-kernel+bounces-530726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5BA43783
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9AE175EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E8260A2E;
	Tue, 25 Feb 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7VchIXZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B625EFB8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471584; cv=none; b=hzDoaCUzfh3KwjBkngxWgOcCsdknSzS6Wx6HOcCmQV2Gs/ruP2xihrXs2hWICHfXUmQa0qRE+2lLdnJVxVZCkjvAAq5gwvcIBID0uHp86oppsaYTfGM04TH0x2BK1DkrjiaxW5JCbRYm/U9wHOGFpo3FkZYd+dJzxNEHSxWc3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471584; c=relaxed/simple;
	bh=X4Rwqhge4ZHSgWe7CXXfacQmhKs7JKLp0sW/JwbmXq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UT/l3CpFnJ9GzNP73iv5JmghAD7ah9NKOCZlYlchRnGtyXE8FkvWeeJf0T7fJ0X3Q/X6uTiW1v6iuuHV8iUIiPtuKOBU/wue+Fl/aQlkoCT2AtVag+SFHOmSgYfQ6tnB2sd5vslkgiwx6jejRmzUisAl6DdbbvXAYNe2z8gumrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7VchIXZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f8f3bd828so11628465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740471582; x=1741076382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx2QrLQuirMCQwy2aokgi/+k+IY05gOk7VQO5JEmOBQ=;
        b=a7VchIXZCJHvwGhgmTpjZgQtTaC7bGgsXPklUocqnmjq9UbzGAEEcjkUpPos/E3i9R
         L6nq6SQav4+HoiW7LXgRcxME7eYbsI3iQJtoQRlYxQZUBBnkUcLigOb60Et4B+w+YMVW
         yMCqW1k8v4LgtB+MDO0TuxvG4hLA47Zls6tey7IHMpn+xLK2a6uXHAe7/TEa6pmUeKEs
         BnMDM7FGRtG4x8f743jKk7M0nFpUBIHfmEp4PXEHFPMZXLdW3uON42uZob35It+uLua6
         AL/8oq7y5Uhf1l+3KLLQdSeBYeyS9ms74NYRXFKtbQsD62jUB85izPRB2C04M+xb9iQx
         6sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740471582; x=1741076382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx2QrLQuirMCQwy2aokgi/+k+IY05gOk7VQO5JEmOBQ=;
        b=Coz+jm5BmwMsoFY6YKNBiIfad2PJGz5A7vojtrzuRyeoYHDtyMyGL+/Qe4cwNY3jNt
         DxusmdL4fIQPazVQLibFTpJMhhS7CqGfpJyq+1NT9fSurfdMTZwWftjbG1h1COiB7kA6
         gt62gzs2akVXmdz7kdIcjLnwo1blYRDip4U0d/1xTX0H7UIDVWbzkWdwe4xoHQHdUT/a
         d30+YXfDuDJmVBS0TD/wH6SbjSPSDCtGegx1I9cGd1sj/36CcppUhtrl8srr/2IWtFB5
         25xLRMaPYvhPvzjDbBQFwX6XdNZ0d4RlqgOi3nKQWCqyJjueRyx/N2COThQXaI9jbcvQ
         j8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGrp8T0esi1ikaKFtmomUJwptZFDSfb4Uc4cLENqKbGs2GUpxxd/LaD5TjVN2p2fR3+2Ae674kzZuxKuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TE6Mr35IscsskFmgOdJnah/M38ZgyTRA9bgiczZW/ZMT2IyI
	Du7MLWBdYfPHqnhux647/+BdXmc7r/gcoM9UTuxVFOEoa2WzrjlL
X-Gm-Gg: ASbGnctUMvTl1FTJPnzJaG9GWtrKnm9WuowUlAw6Nln9sUl8QJG1+pBT1dZpimADrwN
	h+lKVxwrKcYl8mlFRnF2MFNAdiQMbESqcIQxbM0eWBVzJv3dchrCFLevnEWNFCIiwH2Ns2XMYX9
	nfJ8Y8FWW5gOfmYyBOa2x8vpCegXw23v9s2ZnFAB0CqIYPmQJv+AOcgxoN0qUwN3ACQuoeyLuYF
	vX5CINJP8qvzU4k8bu2PzzMy5HZOUu3ELZOHe86EKd6osflvrM8dXym9uqSvbxb+wwvZ+vKzsvR
	S9lBglzgFqMZza0sclAGxqYvNU7YsWLWoBjXCmWlhQ==
X-Google-Smtp-Source: AGHT+IFUZ921XcZ5J+TM3sPegqR9smZXw0NsQmGLu6WmXG02pXk6UoE/wAMIzm34jMd5imF3JFw22w==
X-Received: by 2002:a05:6a00:641a:b0:734:3d2e:18b1 with SMTP id d2e1a72fcca58-7343d2e19b4mr7936256b3a.2.1740471582432;
        Tue, 25 Feb 2025 00:19:42 -0800 (PST)
Received: from localhost.localdomain ([182.148.13.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6ada9fsm943955b3a.17.2025.02.25.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:19:42 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: matthew.brost@intel.com
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Date: Tue, 25 Feb 2025 16:19:32 +0800
Message-Id: <20250225081932.175586-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z71ZM9Cs1Wb4mhD3@lstrano-desk.jf.intel.com>
References: <Z71ZM9Cs1Wb4mhD3@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Matt,

>> 
>> But also be handy of could share the kmemleak trace.
>>

> Agree kmemleak trace would good, include in commit message, but the
> patch looks correct to me.

Unfortunately, as trace involves private code of our driver, our driver has not
yet officially entered the community yet, but it is already on the way. So I
cannot provide trace information at this time. But I will update the commit in
V2.

Best Regards.
QianYi.

