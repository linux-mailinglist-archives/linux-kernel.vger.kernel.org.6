Return-Path: <linux-kernel+bounces-198143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D81F8D740D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD41F21954
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9BE18EB1;
	Sun,  2 Jun 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSGIDRpK"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2821360
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312139; cv=none; b=O8WdmMipln7G3PFKQza63ooNK89Azdc6/oC11QfcOyyxJQd5HRLw+B66Vm+mH+M1UvGwUMwA0VU/C5KZs3/eCzQqumV4d1pqh12Hy9SPnvgzDkpZh92nGZvV43rqcEdERP9mVBREQCKQ3Oqu8lTbVYplmBCX/D4COLiFBjgRvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312139; c=relaxed/simple;
	bh=gKUM/KW3iSLa4w3XPzxQSgDSbU18u/D2UZTh1jv4FhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zi9vwpbHYqQKE3hBJ4mIdEcTmK13IcJWcfNjrQo4dqjnSzwNNmk54ZU09rnUPs5U6hmgDuhJxynnxW49uPmhW9+TgJg6WJuA8LBDXZxfmpv5KsEDGnZFCoCXS//ReLxa+6Ek3KWDAhGFUtHg6nSextBKzWzzTkG/OC4ZpBKHXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSGIDRpK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dcd5377c4so2519393f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717312136; x=1717916936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ6YOiyl/A9+XYvV66iPJpqggxomWAoI9rBqL8ggIUs=;
        b=NSGIDRpKQ50F+3m8PcmbvAeBejYf68enVcyJ+9o1WJQvLB0LuGhjx/8nSgAxMUcVIP
         /pm4fQ629IRmNOhMIsbEt/eR554pujWCjF1v3Vj6MX1S1NkcS27ZboCkrJrjDCd5mCcK
         ZrqtT5RVyRwImNWO4/0+j8lIxB3vjWmy7W5dWItpngCDq6KATXg3pW1wq2mWXK/I/sgA
         3edwzKIJJ0VzmEOnlT0kj7YjE8g8dMkv1m0NOvRu8ctev/QsCbsLbkdZss+RSATQR5kH
         4+tRzig6EZTHc0U+4yBdNFP7PyrQ3N/a67cKiIcq+OecUpcxINc2SnbGd7/va9GyzpCS
         aVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717312136; x=1717916936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQ6YOiyl/A9+XYvV66iPJpqggxomWAoI9rBqL8ggIUs=;
        b=Fa+uxAXUiUEkYkU6daKV9Kflhxrvhfh6CibDA6zw7k04WwL7tFlXRwzC37mfcdONRu
         IFl3L4ebV/s63Au99qOrTix513T7ypunPHSumMe8STli8Jxh1xANve45IlnZ3vKUILeJ
         UONv12ToGfDBL6H3O5f491HMk24ODCgaOE1xaTHZgzU8efqE80mKyGkpWEUZi8Att9tR
         psBmj1LW0Hrv9tzW7jnYf0qDNaYCiVjQpJ4ohiVwck37XO1hKscT6v0ozbh3VtpuFbZt
         Qk6CePtkrKJeRrzeOqeZrdjfrOVltDY4RTXG4rIFeCF+78IXt7o2jPTDL9aBDVeNOjXD
         ARXA==
X-Gm-Message-State: AOJu0Yz9Hr2cN4NjepEXiuEXEk7FbXE905RRuCYWuEyIYvF9XFj5Jcme
	Ny/6Q6He1Sm1koSKF8fwARK4efgn9n/aUH0r/H2/iylmgGQdDSE89HXK6YvR
X-Google-Smtp-Source: AGHT+IGriSulddDdo8WqUbAG+qBhSedmgn4K+OPkYi6OhnA+GPPylHnoeNeMgTqhpMc5RdveRRrorg==
X-Received: by 2002:adf:fd0a:0:b0:35d:bf62:773d with SMTP id ffacd0b85a97d-35e0f26c808mr4432657f8f.16.1717312136125;
        Sun, 02 Jun 2024 00:08:56 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064ca96sm5423249f8f.107.2024.06.02.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 00:08:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 2 Jun 2024 09:08:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fixes
Message-ID: <ZlwahYzxhwYTa7IP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-02

   # HEAD: dc8e5dfb52d56e955ad09174330252710845b8d2 perf/x86/intel: Add missing MODULE_DESCRIPTION() lines

Add missing MODULE_DESCRIPTION() lines.

 Thanks,

	Ingo

------------------>
Jeff Johnson (2):
      perf/x86/rapl: Add missing MODULE_DESCRIPTION() line
      perf/x86/intel: Add missing MODULE_DESCRIPTION() lines


 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/intel/uncore.c | 1 +
 arch/x86/events/rapl.c         | 1 +
 3 files changed, 3 insertions(+)

