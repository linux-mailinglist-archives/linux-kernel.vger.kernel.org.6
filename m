Return-Path: <linux-kernel+bounces-282058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DAD94DF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526881C20B55
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B008142625;
	Sat, 10 Aug 2024 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWJd4BJk"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC213D285
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723333982; cv=none; b=s1VO3kDgddBtuNWz8mr5UwsRzo+n+uNzgss1L8FVnNzbQewFRMp4fVQkHfB8m+rb+4bxb8Af/fDfHsnNqJxojeqFSGYC6aHyFQDdgKGPJHli1h8j8P6v3lpSY/vzfIBUQbmwHwpIX13BLuuMxysAXfNggzpY+0dcqBaUSZP6ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723333982; c=relaxed/simple;
	bh=JJ4hxCgt/zZRGJRZcW2lxFYlxh1Kv1BkXwpOc/rkGdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fjivb1ul80i4vYiRPKdzqp+Hbbxxp9b3KLJ/6sETjEihw/erfkk23w7/iBHzpl9jIQ8xNSDZ1TkUS1Bv9JlSvohVTaqQ0TNY+uR0tDGbxig+flVJDyR5LxtOePCL6APIYERscPaxe676lKxEFZbPVMgKecj5E0OCNT+2+dvDCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWJd4BJk; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39a16fab332so147995ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723333980; x=1723938780; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgxdgCi5bSfE/GAvB/15M/mq1SHMagercw+5Gq3yw68=;
        b=bWJd4BJkVXDEhpT3XhDbmr9k2USyu5zEIbOIiWYvBg08t7xwkpwmacIJ3N3lcn2i/q
         YZUe/9jSjkTUKiwtqTxlxk0lS5gFevl3Uhi4/PJivhyn5lUa6Zq7Xto67jd7f8+N9Jz+
         GdCmrZvwAJxL1rRELpwow0tnjmrXF/v2RJ8aDBeRWSKJw+afeTQ4cwcedlxPMJ6lc/ec
         ljZUm1T6A2hHNj9uXPwFw8KsTzpNxtpzm7lupiZnaB1eb6aCbyDM/xULGgDK6WyLvlRS
         jAlaY1FIm6ylxObYv9Ox4USFehZ+QYRcXviUQDL0XspyahWM80MNNOeTAiFzEKgQm7uN
         TvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723333980; x=1723938780;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgxdgCi5bSfE/GAvB/15M/mq1SHMagercw+5Gq3yw68=;
        b=SgBdvngKSrgZtpJFsZepHbps5jLWfkqZb66/sYHTius0MxJ9LkZVOj7mF7FFm48dK/
         azZ/l58GIs7Rig0vcdSMSamFQiqaOgsbVhWwmQjFPwF6Br+5PtS0wF5BDfcnaRzU76Fi
         8+HRBtZM4JqL6SPD5mJqCQwELnsQpf4y2ctGLoE4QaLhauzi99V2ce/lDwgunXUTJ+Nh
         CnZRbzNV+Ryvx/qZ0/8fi4FhImm18E8nYlMQNW21YW0kWctIFU0jt6RCeW4YUMXfPIjL
         vyyf46T008lhIbnO7Wj5M4qzkR3vR4bBNU1wgMnKojEpptwXGJc7OIFuYQVftBuqTFFk
         C5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVwsIHCsGUqxjEc90xOx5HrFTXlXxcscdhUht/blpk7K79xCufDhFILm8Z896yLtS5GDLKMQ7XPFM2l/0rWSJ923BaWgNudux2jQl6t
X-Gm-Message-State: AOJu0YxlQHKb/PyZnb9L/RR0NE+UWpUE5phxSr8BTdyaAzzNubZ2eLoo
	wjOZyVTW0PFQfPQC9MN4xtlLfM08eRlxgz7jTVxpkhUj1GHnytGuPbo/sY79Yg==
X-Google-Smtp-Source: AGHT+IG9GaxuyPHGuUtD7gW7fpHR/LYezf3P32bkziAiQAo4kNJTO5ydInMkzc14fFTOZ5OcEEZk5g==
X-Received: by 2002:a05:6e02:1609:b0:397:2c0:4a58 with SMTP id e9e14a558f8ab-39c314ba612mr1998525ab.29.1723333979838;
        Sat, 10 Aug 2024 16:52:59 -0700 (PDT)
Received: from [2620:0:1008:15:8522:e02:424a:c5b5] ([2620:0:1008:15:8522:e02:424a:c5b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b4dcesm16021725ad.139.2024.08.10.16.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 16:52:59 -0700 (PDT)
Date: Sat, 10 Aug 2024 16:52:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Axel Rasmussen <axelrasmussen@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH] mm, slub: print CPU id on slab OOM
In-Reply-To: <20240806232649.3258741-1-axelrasmussen@google.com>
Message-ID: <4e06d3ee-de78-9a71-ccec-6c0a5aa0c7f6@google.com>
References: <20240806232649.3258741-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Aug 2024, Axel Rasmussen wrote:

> Depending on how remote_node_defrag_ratio is configured, allocations can
> end up in this path as a result of the local node being OOM, despite the
> allocation overall being unconstrained (node == -1).
> 
> When we print a warning, printing the current CPU makes that situation
> more clear (i.e., you can immediately see which node's OOM status
> matters for the allocation at hand).
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: David Rientjes <rientjes@google.com>

