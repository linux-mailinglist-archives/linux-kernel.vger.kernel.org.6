Return-Path: <linux-kernel+bounces-310395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948B967C2E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3161C21293
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63361FF6;
	Sun,  1 Sep 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFQsPOk6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9F1E517
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223637; cv=none; b=s/ACQT9AOSd3gBwLa6+YL8/OBmNb9oldXsdTak2qNlK5HNcIqHS6S/CzsvKdGcLlHknAjAMKzicreAVev+OqKxd04uA8ruIQFvpNiaYri0gb7Wl81mXdnqp4I4EWTgs3iM09zhlQhr2OSXJ6Cxs2h9XTDMzaDO98PHr4gbBc9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223637; c=relaxed/simple;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZe1Hi2RoUjA4mM904i1KYOoYbsjDz5RkWfDgOEFW4nwgT5NKCFtH64LDmgxpxi4gambvyzSJmJ2o/ApijQHWMly7+cFM3cAk0AlyjomCvnDJuiSTG7BQ+XxSymxBcUVhT9+8IEaDn66x2jT8KmH26VCU8gBTApPa9hnammqQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFQsPOk6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714186ce2f2so2893356b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223636; x=1725828436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=CFQsPOk6nK9OYDgdvoo9QpQ0aA1zlDgIGgMQY96wisOlsblMVehs753srFfSLrKm1m
         c54oGtryYz9D5p2ZEQ983Quk4lX2zeEGKkHGHB5hCCyUEtpBtV2zz+RNNInbXN+wNTeS
         VWYNyFMvXbhkHzAZR+Ykjy83xFyzZXM0lK96EzrF5mzIe6RZBJIvPvDmW6vyqQqV1BLP
         CzdriUWJgLb5WzRKklG1du4UVJvyGUGzW+nLCZqgCp1eWZ1kUX6MhKrbQEGIRKzq3wbO
         2jLKIuUE5KvW/XJ3HY8ImUOvuaWBod+dOXzmS/8xKSSXaTlsrw2fOtbjOn6lftjy8v07
         0ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223636; x=1725828436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=YiPB22+de+Zk4nmlYvzP0JvKjAsQbGWFoGVCvCVQnsWKklv2uYDrqgyGNFiiYRebXq
         MzrsrPtPPFhjIp7SfJNeOZAb2BMLhflHzTVH59x3iQLLWc6YjkX3FBpeuJOfd1314Hbw
         IzLLTQ9bKoQZh6aQVbVGy9vo/4K6NGrw0ufRcbIuwk904T7KHrvIWKowrS4xtGRPQMzK
         9RaTowe0Sw4+GbmcelOVG79lJpaWudAe4P91hY8i+7d3Sdz1B9sVkjmjlkuQ3J3vZ3qb
         9WgviNSLb8F2O735p/emrvhYPek3NsCNM6782zJsiicRHbFLWosT17RDAOid0oQYAdlU
         nGjw==
X-Forwarded-Encrypted: i=1; AJvYcCW4iNA/n9nn24attUn8LYrpKn5eW5U2EIN8yFxRrZhK9BKzQivoBQVYJcCRcwy5i8lSlcqQ7JEGeqnnQ7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCu+MildYTR5+8dINaJRa4tdga98z7llDsa5Sn8IoL2ItYz73
	+JZitfhxG6O2U2E0D0473y0Di8uL6yRafHD5uxKggDgZ6G0+qQn44Vd2yWC24eEj/U6i0EqQILk
	E4WjFH86U0SerDjdtmG+8NhcjNaTSPhVWdTJg
X-Google-Smtp-Source: AGHT+IFjcGNusl9VTsJCWzBO9oBjystoboVVMqRnULnORkuw4JG3A7lNAfOd5mI0XQ5MNolRI3IQ7m7HJGFxj8kVpMc=
X-Received: by 2002:a17:902:ebc5:b0:205:43cd:8905 with SMTP id
 d9443c01a7336-20543cd8df6mr43061345ad.62.1725223635333; Sun, 01 Sep 2024
 13:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com> <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
 <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
In-Reply-To: <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 1 Sep 2024 13:47:03 -0700
Message-ID: <CAB=BE-QGjb_=VgrTkXABO6M3B04bdaQS=NCQnmp1kMy5qYArnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

