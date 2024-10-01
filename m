Return-Path: <linux-kernel+bounces-345632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFB98B862
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AB81F21F78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5F19E7D0;
	Tue,  1 Oct 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDoQKzzP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7419ADBB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775057; cv=none; b=NGY/35GXJ6/fmjdz1fmnIx3XWu5lH5G4PiEeXSbxUUt5w7ueawICXNCKlRXVZKSwoFMfyaqoiiTKD++8VE3hsUchRD5622KTS8OzeH9PzkH9e107ejRh7s2/qKTpvI+BYbCPLhw1rdjKM3+KZjp/i1gvWWoOf9CimG0U0XVz8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775057; c=relaxed/simple;
	bh=ZskDUsZeVMJFIK/Yigi2D03XvMO2kozwT/rt/TJPv5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCRItJft+IGxf0EXSztUtC8cGVcTBt6LF41uvVbydmmxTXoR4Ix4KKe7D8YfE7WzGNyou6UixvJkuu/VPG5vItmJfKWNHj1fp6vEZ7otDiOjJDS7snWyvrKTK1Ai2o21hZA/laHrUy5csm923/hKSpS7AkvEzYfnUhzn9Otbz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDoQKzzP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso36259425ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727775056; x=1728379856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+4UolrUQ6Xy2r4o1oQrUubFhTKVXa1bQO0YF2hCMqw=;
        b=fDoQKzzPOlXqAOVJdwQxJEt3GS+cPc7p+Coifmjlz+LW/mqq/kH4PIx0H7XDhwudMk
         pd3IGlgij1v0IX6UeisjZV7GLrS56KB5n3B27Djdg+Kbk5FTBiNGRONFsi2Zh6f/o4OD
         Jm5JFcY1uNumZChA7XnmqhCJtPdBNwnzx0f65vukQZvPl2xOIKGqyQyvSWie22qo8M2i
         xLMDwNTFU45RMWhtKqf2xpLEnGBdxGMoSu/gDXRx0hvwtEn3OR2u4ZGOk7b6kJHHT0xQ
         bi2N1YMJrRBNAfw0dtVyDaW2WTZoG5cwXl1wA8jWQiy66SW//oab3rnZX1nWEPuBhMl1
         gtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775056; x=1728379856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+4UolrUQ6Xy2r4o1oQrUubFhTKVXa1bQO0YF2hCMqw=;
        b=i1iPCdR3orqqOAx1jbMXKp0DWfoudcWCrUes2M+HaOmS1oUnHcvulcQn6BOfEcwCzd
         smWCoeTDXK7vsBuPBMwfTMh9PhU/+BfUiuoYvGcsCSuowrk4f21wCQmzSGvridXNVnFo
         hkgtkr7ZjXnK0Sb4xug/sdRs/SV+ih02/SiiANbytL/LXRAZs76YgpqzMMd1Zv3WaTE9
         56hPwXhXEseUlbt1wYR/DImf7GIg4XH5DCW4ytKtJraWbBpGkCZhVZmYzOqPZIRak6vt
         HzAgA6t0gO/jSyQTt4totIh6z3RNAXOawXpbi+iR1cqR/teVggCB63UPKt8q9El5aWh7
         gi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe5iJzlSB89Rb4xDs2Kt+qRueQhni7ODs7rVzN+BQz79TOh7uAXldsaQ7MbRGmYhbhnr5RrxMoNraWzLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOBxJdMJfqe5vMVGXBxdoY3uKngrt/wPOUImHwfD4FvvOQNXx
	p5+NOBI4PUHyd7rawdjNaiCIdGGn5EhfK7pBCHAC1pDjU2qvFGE4cV8aJwqacfAr73sw
X-Google-Smtp-Source: AGHT+IG3MRTXsdCNxSvHbHz8XHYStnncZOvWI6fDhmAE9CqqHGPX5KMyzKCUyJKUNaPIYsVfDRSRSA==
X-Received: by 2002:a17:903:2344:b0:207:1675:6709 with SMTP id d9443c01a7336-20b36709fabmr201291175ad.0.1727775055866;
        Tue, 01 Oct 2024 02:30:55 -0700 (PDT)
Received: from localhost.localdomain ([175.45.38.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c74071sm9782805a91.18.2024.10.01.02.30.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 02:30:55 -0700 (PDT)
From: Wenyu Huang <huangwenyu1998@gmail.com>
X-Google-Original-From: Wenyu Huang <huangwenyuu@outlook.com>
To: jasowang@redhat.com
Cc: huangwenyu1998@gmail.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
Date: Tue,  1 Oct 2024 17:30:51 +0800
Message-Id: <20241001093051.42703-1-huangwenyuu@outlook.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
References: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It used for testing in tools/virtio/vringh_test.c. 
If vring_new_virtqueue supports packed vring, we can add support for 
packed vring to vringh and test it.

