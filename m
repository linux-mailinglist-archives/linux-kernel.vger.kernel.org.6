Return-Path: <linux-kernel+bounces-241169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B197C9277C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C489C1C22BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7C1AEFFB;
	Thu,  4 Jul 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxSYCyp+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4C1AD9E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101927; cv=none; b=pEGk6+YaNTYFEcFEebG1qk+55TYaF8rsG+p5aU8XZ6veQ4uWcgInJeqWmg4LjUI/wR7X4WHcijQLT3WBRfWiTlbiODAG3PAGmtMMscasYdv1Q/l8ejoeGoZQt3OfUJN/j2Jd5ncaKWIudFNJHKD/2QQh1fEgnEjC4BdqdZ02460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101927; c=relaxed/simple;
	bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTFcb2kmJyCeoG5iDb3tFCGW05KR4muG5KkP63/A80//eA86A2CKIKHYyw+Syz/SVqZqR+yS+hILeJ7Nd0pnGJbkxSH9c8femvQAn6Y7UBO1+lOelE2H/JHPnlLrgbqkhqHX7XQEp1S8EaPE8qrhQvjHJyFTjmJQSi86QVH1/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxSYCyp+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6513899bbdcso11205737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720101925; x=1720706725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
        b=VxSYCyp+5aPScQeE8OnbJvYcUvekY/PO0Ss9nqYUklx8bs7+M77E3qAlwVuBc3RVUl
         BNyQjQ9+VdeZaBJPQsjvHvPs633hZw1cxdzXFtAaifXcHo+wRPh/oE3WYIM4foVY9HVH
         Am74hlPlASnY3sJ6O4I/lW0E5K3LJh9J2SB3qCclKI3bs8o3zCmgsQzMd8EDK7ZKNByG
         hqviJwUIzJ5mbzWDPazDBXUrilQ2jyDIHsBc44bmRSYEyYjpLKCRAThenVv3NKva0jLU
         yTGqQlFg87amBG+fOIHvCN07LJwfzKXTvxMK6ECYB3y+F6moWVrbvYj/2g0ZdsV9qsj6
         w01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101925; x=1720706725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
        b=uX/RSyU6Wffskg2Gcf42figWPQ+BxSp/IdETPBDxlHd+vUfETME1nn73+EvqYZFv9+
         aWadNsxU5Pg2GFZiYQHhjjJGrtwMs8J3GQ9Xv33PLJpeclHHzwum2sszgiNhYkCk9PQI
         +41hGRNlq9BZBh85Qw6ctSt1INtIaPytv1nnUbWwTVnEVofHnBphWHXLXLfJ2uNRiroz
         iL2sBpr7EMBqZm9z0t0iUE6Uf5KCle72fykWRNtFrBurnV0SjfxPDEH1gyYkBzoo7qc6
         VDZgG6Q9ip5kdSqZK+10So7220LfYRlaTM53BegRfkXCKsttFpgP4JOcxtnBsHU3uFtq
         mDgA==
X-Forwarded-Encrypted: i=1; AJvYcCWKBwOI2ghsXQ5kZQU7gAWUeBug+wbF1pO/f2OumA2fA6KM4uHqDN8auL+CowiLsr3+CpKisohNqDLUR4wJo+5s4I++0iHh/9MEGAyT
X-Gm-Message-State: AOJu0Yz48CYbpOHmwBzvrwh1MxMfOlvQPWnhENessJvd7qAOrf0CNXts
	NqRb5Smkc3kEjCv0KKzmugDAV72Wa+BTLS+gsYwXIjX0VA1Re4D08MD91JZ6z90G6SYrKnMZbp9
	tLuY8Cw==
X-Google-Smtp-Source: AGHT+IEUTx9gA7idJniZJ43DFyy9iaha2T2C5xdXkzxMT+Hu+WTsx0gWO2mYAGlalubEcYYltx3s+A5MabGu
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ef38:74e6:67b5:dcc0])
 (user=dvyukov job=sendgmr) by 2002:a05:6902:100b:b0:dff:396c:c457 with SMTP
 id 3f1490d57ef6-e03c195ece8mr3031276.3.1720101924876; Thu, 04 Jul 2024
 07:05:24 -0700 (PDT)
Date: Thu,  4 Jul 2024 16:05:20 +0200
In-Reply-To: <20230926102454.992535-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926102454.992535-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704140520.1178714-1-dvyukov@google.com>
Subject: Re: [PATCH] fs/hfsplus: expand s_vhdr_buf size to avoid slab oob
From: Dmitry Vyukov <dvyukov@google.com>
To: twuufnxlz@gmail.com
Cc: akpm@linux-foundation.org, hughd@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Edward,

Was this patch lost? I don't see it merged anywhere.
This bug is still present in most kernels out there.



