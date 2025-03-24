Return-Path: <linux-kernel+bounces-573727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C684A6DBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EBB16AF31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7C25EFAB;
	Mon, 24 Mar 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gebCyklj"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565F1A08AF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823176; cv=none; b=SA8Ort9ZutM3lsaZD/xqi0LB/4Kiws2yVLjYvrId8EOEBWThBN6wMPwHviQjb+gSgbpEV7D53TM9j8BcpeJDmJyfgbdGcjBee6FqDiGNuRpuRiRwkWraXpn3FO1BryHD9N7tznJ6QDrIiKf0HGkGLGa2uWI7xCIQ/LkAjIbg2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823176; c=relaxed/simple;
	bh=jyMXTLyNgoR+3Mh43uHX54/Ii8JgrwxoERkKPkXm7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDko4D2edYApp37FQIPqPZQdN+VrHYUpsBMg4N94YRq6yRLMXrgz8Ue7wDXU/0QGOj9qDR+gzuTIWJsDdhYrKSZW/R9FqC1l10KlJoe5SLIwO3XKKvPZVCGg6orkPeZlu1AZXOnzSzoQdtD98FhWL2zeNIlJKttFO/NwkuHKpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gebCyklj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f254b875so39398976d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742823172; x=1743427972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ3k7yEhYDRnLKFARJZHNQlKgfuegZSgLZhOzT1gU3A=;
        b=gebCykljom64PRfiMPz5Rb9bwBFSxX4MbQEFO4m0eDTy1ODTtv7k2XjH5dbV+AbV7u
         zZ3amKMtNneMeV1wkqgiFzzyw8YM4U1W2B0Fy43wDwW1EI77HywLVsNXTdZE7/LV8NF8
         03sN9uW9TYZei4WYTYk46yqqw9++n/XE7zRLGrWpCrz2VCeOJz76rpnL8UVHukXESsQB
         eBOk3RwNvLJeOWJ0ggxUageoixKLtNeXFdHptLKL5M1QJc7ELe2A2v0DmrXrJ9N6Soxo
         HM49bWCVUVcWbXxcEl6d9o/VcMVQfz1gKA4ECGSdDbCpNKwQ5m3dVYsOaT3LtoPFIvDw
         6d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823172; x=1743427972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ3k7yEhYDRnLKFARJZHNQlKgfuegZSgLZhOzT1gU3A=;
        b=RnHLEkaAcUfas9rrLrfMY6OCZ++wV7xKuMDe1JT+K2ek2oI/NxsoMzZxNUcsVPp4sj
         Y5BN74L9+3xsJ3BTAiO5Ynzk97c3WR49Mskjo8HQ6DW7fwNxAH61uBVLbuEex9e5jVE+
         zwTHA0nSXaTGLP7ulvlMxzbXwXxtt3sk/vD+hzn/0rNzKGgkQ4ESsnEhrx9B35Yds4g7
         dmZTIfnE2wY57thAnGproaMuwmZ5TH0Sg1v2sbvgPg9NNrFjgasdDyvYyLa09g1xK5ed
         BUgkudrcC4u+D1d034CS7WY/mn687S9Whlj6+8uZKGrTkClVoRNZNq3QvVQF7bMvEhFF
         j6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWKcJ37cSMYt1XlIDd5lkgW45rjTK/+ruBWrEhNRnWo5ABhzyHc5DHPFN0P0U0fpKnzEpya6PVVszFEKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yu5fpXYkC6hxH0UksUJZ54wGlKDrwKkzeiezEoUeVQ5oWwIl
	4nystgHr9YP1f4rOISZUVf5A+k16wlCMekSBmm9m4okYbUTHn8QzaapZ33OQ+zA=
X-Gm-Gg: ASbGnctYPQ5lxSoz2Cyml6/ex7ySvZN29XPC5Q6xo2OqYZZFcCgVXXF9IgJxEj9wc9B
	z8wpjvIQibGSC3Sp1QA8dDjXihXgQ8TziN5oms9IHGUp2iz9PKWdk+Ydtn/Y51NQsZhBtrXeNa2
	TMJPthcFQX/Pf6r6GgqEjwiJV1qmSCgGZp/9YJheOv9lo34q5pl7pwcW+o80kiQUJjt9mxDTWof
	4rtDaLeH18Qzt4lNKetdGYgM/RIF9PR9Wx87++CB65ZRSJjhxaU9bZCIx7a1Yj0PgPdltKXqym+
	UnA962wo5Rydn2rZOszriEu/ygc6aKio0AIWYL9cD3YYfel91Ta1ZQ==
X-Google-Smtp-Source: AGHT+IH6AI2Hu4EvLbPfd+tJ+iT15wj0QMHGeMvnf+rKbGzhr8KsnPvdxaL8QbRANSa5d3GYbYPvMA==
X-Received: by 2002:ad4:5f4f:0:b0:6e8:fe16:4d45 with SMTP id 6a1803df08f44-6eb3f3446bemr145244976d6.41.1742823171962;
        Mon, 24 Mar 2025 06:32:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef34792sm44450036d6.68.2025.03.24.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:32:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:32:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-FfAUiGePF9mnPS@gourry-fedora-PF4VCD3F>
References: <20250324084920.987-1-rakie.kim@sk.com>
 <20250324085433.998-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085433.998-1-rakie.kim@sk.com>

On Mon, Mar 24, 2025 at 05:54:27PM +0900, Rakie Kim wrote:
> 
> I'm sorry, the code is missing.
> I may not fully understand the scenario you described, but I think your concern
> can be addressed by adding a simple check like the following:
> 
>     case MEM_OFFLINE:
>         if (!node_state(nid, N_MEMORY)) --> this point
>             sysfs_wi_node_release(nid);
>

This should work.  I have some questions about whether there might be
some subtle race conditions with this implementation, but I can take a
look after LSFMM.  (Example: Two blocks being offlined/onlined at the
same time, is state(nid, N_MEMORY) a raced value?)

~Gregory

