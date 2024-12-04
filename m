Return-Path: <linux-kernel+bounces-431634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBDA9E40E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA7CB3E1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AD20CCE4;
	Wed,  4 Dec 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cbOP1qWm"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCF20C480
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330010; cv=none; b=PTmhTZyNPK4xlpw3pSMshr4ZqnRwv1NoDpeHWpL+CyR4NePskd/n1hNj5xYFhlX9WUnINzZTHGQISnGqgDiM6euytelue0K+jZFWhEsz13gfEx4zO1g225ItapLnP5zhJEcxsR8n77ddwM4h0wJhmXVZdRi9Mwfft4oJJjKu4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330010; c=relaxed/simple;
	bh=YLqX/28N5thdvuWAhBCT6xbYIfwdHgRjjlYUHnZfPww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NdJZuGzXs5VUZoLK7SnPPAcBnxP6UIJ222jHMr0j8fZWOvXFArbDyKF3/H+GMyqvTXEpNWLrNUNlILjyU7jx2Xy5Njbc4wRqmNdWfeZ+Q3zujcT+NwXjWzoDatzPQE+sXjzntU7ax0OtArDo6Y/yosBl3X9Ln9LYl72NV+jW4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cbOP1qWm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7256dc42176so11139b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330006; x=1733934806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=cbOP1qWmavkAFYTjIGGtxmICesXawjm7Tw0HYbCU1e44Cjsq1mwqI9RYGBfu4ZdzCK
         etKRraOqeFHs+Ev7wG0NXqYDvsRggihA2pOCYbBGpiJviaXUzVZmna5PzJxDURJv+Cm7
         5Xvk9nJxjTGRomDor9qKlDvik1uEDVH1o8ZsiaeKN5p8J/oyplIlNkbF5iX7vdlw2FOF
         DxeKZo2qOalyVhtPNcerN3p9rSaWa517MC2NdiNs5wmvWOoIjmX8enlrB2XluUmce7PB
         zjdgkdN25dDPEYQ9iH4uN90fOFkmqKuhbeTqYDPD/tT5+20PN3jNwbfzMa/vZs79YmSa
         6epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330006; x=1733934806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=qoYwjWkzrg3QV8Gn0KdnFU1TgyhmayBc8fQtotv3S5q+zaX1+CulVqeFIXBICZqGuH
         TGzD5fJCyVa/TcDt714JHhbXjqMguyxCuAREk9JWhz2C7bbiTXbxUFjKq08iixMzRntS
         qF8Y2zZSmOkqslkpBxKdGBOOMDnkEU0g3c15Gj3NFJ6mPrlQ5W/glM7SzgyKwaHHr6bw
         ICDkeu5WjUbRonbuXJpONfjDSwnZ2Pv8Q/iGJw7rDCrrwLIxase/uyqq16c+Q88jIQoJ
         u4pqQRx05oKCPeszqTSXgTDWpZvKZa7/Q4671qs59R3ANJBw0NNz/1VGCrqH0zDdke8U
         D97Q==
X-Forwarded-Encrypted: i=1; AJvYcCU92mGGlDNVdghCV1xQZpu/Nco5qJ76HXxisJBSVq5BO57bNlqipTddfszGSxFXNkToz7jevqM3KVklEBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhTyvuf5mr38ixi5xDvklUwtowo6X1nU1NIv4U3WR5055IXrn
	Y0xOXjCyYgvKeyxAARl0omuZ0j361CKcm1k9ZbIDr2DbHwblTfHbMVd3mLANH8E=
X-Gm-Gg: ASbGncuOXUohr3dKtGYW//u4oGtM7CkQOZjfIcy1ZHkIv3oRyxJcDrtNjanJcSdYR24
	iTqBaLHMRFhY8aTIFOCjc7xyO+fe+ANcQUMAhfdxPHFNaR0deN1+qX/mbPjhJSB32r8i7/fhTXz
	zrkA2kGC8D2B8LAUYypTkHrUt8pH2Sdm2W5D5detN3em40pIKxs/Blms1ALtAQFbE1G+O7fPZfl
	4s5bJGJuQ3vuP97d65tpwDd+siOLw==
X-Google-Smtp-Source: AGHT+IHGetUSTLBEO7g1Mr54/8uXPJm1zbpOiVPZj2JidglSRGFFA2sX/e54bN5zcvRXs+5U75O04g==
X-Received: by 2002:a05:6a00:995:b0:725:2b93:3583 with SMTP id d2e1a72fcca58-7257fcbc006mr8373190b3a.21.1733330005713;
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm12955492b3a.185.2024.12.04.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204150450.399005-1-colin.i.king@gmail.com>
References: <20241204150450.399005-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] blktrace: remove redundant return at end of
 function
Message-Id: <173333000444.511414.17569005007152720429.b4-ty@kernel.dk>
Date: Wed, 04 Dec 2024 09:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 04 Dec 2024 15:04:50 +0000, Colin Ian King wrote:
> A recent change added return 0 before an existing return statement
> at the end of function blk_trace_setup. The final return is now
> redundant, so remove it.
> 
> Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock")
> 
> 
> [...]

Applied, thanks!

[1/1] blktrace: remove redundant return at end of function
      commit: 62047e8946da6269cf9bcec578298dd194ee4b7f

Best regards,
-- 
Jens Axboe




