Return-Path: <linux-kernel+bounces-441771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A09ED3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF68F1887530
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D71FF1DE;
	Wed, 11 Dec 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un/3+NR1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08D246335
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939202; cv=none; b=sq0lIJjo+bZhvdCs8TYshlZ1WjDZumfey5v+jErhoYEZYGGBN655mYves5osGPKM4eVzhjji0hht5XkaPtZLwbxBumE2AsGzf/7yhSz9JYuggT5trG8P9xAf2QmP+lPBVKp6fjaDZ3Dm5FPcltrK9Dbtcgze0i3SogYInMBsQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939202; c=relaxed/simple;
	bh=uTbQ+v0ZMAwULkEAlk1ZZxsNk1tcZ6KbogLMS1sAtG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6DfTd8hNmApwWpHiOBuM4QKSPMPNTKP2usviNdepN8AiOKw/vkf07aGQ1rm62Z5oQBA/sn+ASF4/bA8exZD1WwKmd/Q/P2ZW5pnZpPezatvdMlJXXPYtIoiLqEAn2WHFUAdm1UZwTbNxSbEimI1orC+fZNAWMjsnPMVpowszlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un/3+NR1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso43574755ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733939200; x=1734544000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yk47WhmNKyrWOe8f3zYl0zI6xnknlbcC9pXMEPbH0aI=;
        b=Un/3+NR1+wySaTEuZiJhoNF9cunFX6lA+VoK5vCjsMHpsOIWNXlz052lnGLIO8W6Nx
         sDsGrI2facEeQAqhXHjBOqCC7qTZbwfGzeIF1pK4xcq57QARt1V1/hxfbHIUA/x+eY0b
         m43JtR5u8U0PaujD3lNHuXaPu06ii2jZXLE+tFzD72zHYsYF0dKtqUK4O+aVMjhyX9XQ
         jdOHIm+gUOLcoqy/NUKrRPCl02KiQjky4TwAP3YEQekOqXbHmLEL+XWaCqyMhUKOgoJ7
         uahQw/dOElCxr8xdbhHWZSdnLzs8u8+yL/f3IaUAvR4FelH2QIf010OE4eNjt+tTmrx5
         j8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939200; x=1734544000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk47WhmNKyrWOe8f3zYl0zI6xnknlbcC9pXMEPbH0aI=;
        b=Bgyu/yTFf9JUgi/l9Hn4jQCCIpHK8lQR3QrBuh6N+VDH5GqbjBeM98WRUtQEddhHZN
         ogI3GcLvHJCREI8TPiihdgsmPU5JmvzBLXC/OlgZRIyxt7dBbfRoZNy2U5unrhB1Yk9j
         WvJbe0Bj1255W4zJ1ppgpCAwNcmtgC1ZYo+2B1J5Z0QjL+ug2xR8onpA64pu4UQ00EBk
         MshKnJ2H6CYaN5ae8fed7f4bOwdiqEXLi/T1+ZKnSjkn32DCCzUiGbcUVSy3I88pskBg
         jDZDw9XWEpil+j8w46oljr1xhFUNdvhRZsQdoPs8L8DPah81RSho1rsR/He+adQypmJk
         Opew==
X-Forwarded-Encrypted: i=1; AJvYcCWwvBx5UeK86cIqvlBfPDE5AnrL4gghMEMKTENQMTA6imkdExJtNv56x+SRD10kVYEJJqYSzPRopAh9UKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9jUjSx88jacdBnyYMBxUyBXvw//3HYDojweytSEXRljsGNk7
	NfUHm2+yH9+UGBjCuI0xz5QG9k1z0VT9fnnnxJDWqn1BqFNnCJaBs4YfXA==
X-Gm-Gg: ASbGncurNwiruFK1Dd1AhHLeWY2fhF6aGIq8DJR/BF7VIChBWJ/vs5VXH3r+X1GcOXj
	9Rye7LHWks6VqhsPJ7euB6pJh3nh5s3VMbtjCtUN4ZYNbGgLbcuA/pbqxKLuiyHoJzkwJ4cfMdU
	W93MF15UyL1b6qYURFo4vplNa0ORMETFrL+qk8+90tRhKQd7qwb47U6dLGIHOhwMinq/LZ0pMb/
	bhjXQz7z3pivcgFXyY+NL3Y/NKtfkmyA+WhAqPFwohKVaRlPQqmmw==
X-Google-Smtp-Source: AGHT+IFI5imUpL04bZrvw7CEzobJVzuRtaERVUYo2kAOyH2h5d7vLRXb0uSRfuiMpKKOl4ojmibIdg==
X-Received: by 2002:a17:902:e5d0:b0:215:cbbf:8926 with SMTP id d9443c01a7336-2178aeed27dmr9700125ad.35.1733939200115;
        Wed, 11 Dec 2024 09:46:40 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216364e45d8sm68211035ad.175.2024.12.11.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:46:39 -0800 (PST)
Date: Wed, 11 Dec 2024 09:46:36 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1nP_Ooe3_vYfhOQ@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209104632.718085-2-arighi@nvidia.com>

> +static struct cpumask *get_curr_idle_cpumask(void)
> +{
> +	int node = cpu_to_node(smp_processor_id());

numa_node_id()

> +	return get_idle_cpumask_node(node);
> +}

