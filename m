Return-Path: <linux-kernel+bounces-541336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D8A4BBA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DEB1892C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684A1F1905;
	Mon,  3 Mar 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="isXIj482"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A41E9907
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996385; cv=none; b=bHA7HxYrDrXm2en2MCVQ1ZAG8SZTYwUSzlNsuI7IXsWF+Z++T65pz2eOESZyKmVR3Ipi2dFl3MpvVuc6y0wp+tvFAwyP5QDoAcWMEaD2xht72aVS0yyEomBo4MLvUoeswX2qACtzV5DHDNYq3BZ7oH1uSK9lk0Cy2ZlhHnmfG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996385; c=relaxed/simple;
	bh=ryNGzalrzD3yX/2mks/XBFD5n9Vg95McjnPEOR5SisE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dl7Qm2PQpwy+bbvHW8BXQx7hPP2wLX2qimz5xkpVBBwc1OoutoPk6BcrTiTrJBaSfK8Aj9t4122uLG3JnCLN0uaJLY9ssGO6uI8LrSHOo7ZP8XNnhLyog0o+OnArtstb/LbVqtqm2QY1WYJACP/D7rvOB4RJNmadHbUS7L/BW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=isXIj482; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22385253e2bso37862615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740996384; x=1741601184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2xvnbw0JuGYZ3kMUPAj9qebO9ot86k6LgdKqU+QHZM=;
        b=isXIj482IUNa3GnhIwZTd95MvDzCI0mSIjaXet8n36kTNkUp7DCuv7i0T7Js9p4F9x
         r7vNnVx95BAmNWQ28tY5Uhw1PtdUJfJT+375bENLF9TaCVj/AmfNbpSrwD6gvCQzpbqV
         nHeliuOyzA3VcZUHFBUccRjuLhdqz6AMT9qQwzo4j0oV6p1+HqsOSx/RdIDLBIM0sV3r
         bQ/JmZD/zyeiC0NEOln+eQ/QG9hK2EqL78z6k3YqIAW3arkrL8ML4GhtWY10trZfgBEG
         Zul27zfcFx/TZYpmQOVasePvoT8BX2VvefyBCfVMAAJwAwr0GTrrKrVhbUCuQQHPLRed
         AYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996384; x=1741601184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2xvnbw0JuGYZ3kMUPAj9qebO9ot86k6LgdKqU+QHZM=;
        b=gmktKeL1oM9Z32ZmRttFRH9wsaaVXoRei2Y0s8zqaM09AzTASn/gWo8GGTz8GvMdsU
         Fx1iGyLzB1EiV80lx6zUs6KlRRJkFZz3puMXgjLOcxqXMLyUScRI4eZGoaD7LK25km00
         ZMhJzIvFnJssxKi3OEuOsNvnS5Xxz4NKOGJCc/ITEqYRe8dY36jJRoWH+7zmCNx2HJHN
         GUaRVGqXv2/vt0TR1L5Lf4Oo55Ue8v6r5LwUEYbRCSnG9yBunn200ZRXAXySOgJ12P3t
         XjYsdE70zTa5mLIt1Sq9gikZ/ZCfXgU/dTaD3BpUJfK//WEfO0yVycBztejkqAGBib4L
         hcNA==
X-Forwarded-Encrypted: i=1; AJvYcCW3itx+psLLtSsM/aFSJPX8KeS5jn7HsebCo364FtI308wia0LDAuV/JM80LiC8Rz/5khthvd/NISM4v2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhC6W86B1UCO05UCu8DIzQT4jq/J2TltQLUbqYXv9buEwDZZ8u
	lYuy7ak0wUUJ7Do7j1QYedSUicaT9GVFuwv1aMTCnnyRAD9yCaR6ERnWncMz/1k=
X-Gm-Gg: ASbGnctXdm0riw+B7Ur28Rx5S30HnuqxZEUbR/9Tl89B5JV4JEZkF8wfYQBHXoZpAZX
	azIogMJVYAvN1TzHF7fzJ1EnzeTYY+BAoU26wP8iwe2Fx77Q1hHW5P/GrlSavCX0vRkRZ3cOBsj
	Oocs9X2uAhB8pN3RlnYug90M2HI2ovsIkSHLrYnWJ/xDJHZwrFC/eTjG4N8egkpNaKhF4FUgUoz
	Upu0W2Wukr40cu+81QgB+HXY+t/Bx1OgJEU9kl2c7NjFco7xvPRhLNn9SLQqeR4IJCPkvDG28WV
	iOmmlWJrEuC+gqw98oStA+lLRL63ZA==
X-Google-Smtp-Source: AGHT+IHEynmWuf/VC/tNMisellPQ0994Vlxa4c8xxDyclOEyECs3a2rUWIXx0layqxHXPQw7tF9mhw==
X-Received: by 2002:a17:903:2ca:b0:216:725c:a12c with SMTP id d9443c01a7336-22368f612dbmr196639065ad.9.1740996383883;
        Mon, 03 Mar 2025 02:06:23 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm74397275ad.251.2025.03.03.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:06:22 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH RESEND 0/2] Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Mon,  3 Mar 2025 18:06:15 +0800
Message-Id: <20250303100617.223677-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In my experiment, I found that the output of trace_balance_dirty_pages()
in the cgroup writeback scenario was strange because
trace_balance_dirty_pages() always uses global_wb_domain.dirty_limit for
related calculations instead of the dirty_limit of the corresponding
memcg's wb_domain.

The basic idea of the fix is to store the hard dirty limit value computed
in wb_position_ratio() into struct dirty_throttle_control and use it for
calculations in trace_balance_dirty_pages().

Tang Yizhou (2):
  writeback: Let trace_balance_dirty_pages() take struct dtc as
    parameter
  writeback: Fix calculations in trace_balance_dirty_pages() for cgwb

 include/linux/writeback.h        | 24 +++++++++++++++++++++
 include/trace/events/writeback.h | 33 ++++++++++++----------------
 mm/page-writeback.c              | 37 +++-----------------------------
 3 files changed, 41 insertions(+), 53 deletions(-)

-- 
2.25.1


