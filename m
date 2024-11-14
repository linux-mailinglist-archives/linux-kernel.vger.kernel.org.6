Return-Path: <linux-kernel+bounces-409837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3449C924A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87CE282C60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1F1AA78E;
	Thu, 14 Nov 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwhiHQoA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7419CCF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611555; cv=none; b=LqeD9fnSoLCIlEMWE38mUwVL0TRR4ZX9DdRXoSINMx95lRiNPsrZ9SgS8pGEUy7kDYhY8O3UZ0SmiTdA9nzKXQlFDzml0pwyxn665aCcd+SlR3b9X3h3lbdHbSAJvwmV6yBnPjq4ewxbPVjBtLxi/xY1Q2SUH+Zfdyib9eH2E2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611555; c=relaxed/simple;
	bh=8NIsFh9HjLOsPUCctkUZ0OQoop3hB0APVZblVw+P4MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7NMDt0Zz7PHcPN9ftoBe+qAhoLSQyzx84NP1+6LKGT5eY/MVcWjvjxwbiEMYRdpOFb/FwJ8IN+XQ/Qpg2q1rSZE12nIxcI9/vv/q9Ta1VZjOHbg9SKObDVcPYZmUadvMWFmjVjk5QbG7whPqj5v0GQV4YkDlH7gx51U81G9WcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwhiHQoA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731611553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRAysetKQ3mmbtVIPe2O8tbisqHkftH8tQ6gNwLYHtY=;
	b=VwhiHQoAAQ50k3nnr0DgmGkRYyARbFm/dSg8cSjmqX/zysGc7IMdgOqRgMgbnnJJKvzAxM
	Q/9Wxtj+Aj5fyIETzf7rRT0FBAIY3IRCW7GRJyVByC5sApFq1GBe2RVKhI8hY2592FaT3u
	8EoaUHEQeyjgqhK5TEK0Yp1uM8xdEH8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-PG_T6cMzOA6CcLAtN809sw-1; Thu, 14 Nov 2024 14:12:31 -0500
X-MC-Unique: PG_T6cMzOA6CcLAtN809sw-1
X-Mimecast-MFC-AGG-ID: PG_T6cMzOA6CcLAtN809sw
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5ee9de26831so103353eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611550; x=1732216350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRAysetKQ3mmbtVIPe2O8tbisqHkftH8tQ6gNwLYHtY=;
        b=dvtlxhalk54eXI3/ZNMp23g2Jnq6kXpt8a9eR6fHz5yvyjD3z249i/LzCC8ufYLj/5
         AgYSTWKzP4tx8culkml33hT7QbmBo0G93HlPlrcXUy61YJ6c11os3UmZttuESgMwedmb
         vuZ5DpXtLSMW7g0IC2Gw878Px20sECvNH8o7XjYOXvieBcYbdbDe0E5KILne3dZjhCv6
         2txrl8B9JWOToYGAmWZW6jVSVg2LSjNd53xGjwXUcpRXgDThqMvezAWr5fpq9C9NcvDJ
         1BxbveSAzeAjl1sGfgEZmD4Im8Xq/1eS9uFw8iq8T0csFyOdEjVsGJyGpzmKzvls79Dx
         ojYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoJXcIbDNYAfxGOkwWN6oEYPqwH1GlR9Hixv5Cyifr4tgT6IPtHhZEyPKhOIZPyhRgGrleQkLPKY45JoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpoyqiFpmZVpkBBYyVsJSTLqaLBGgExG6Bz/6XWu9G+R6Yihf
	+pcuvWRXlwblTmXXqtWTEZO+X4gYlWSv7CQpsGWkvdtSjKE0mnIYnK341ev+9G+Rhd+ob9LxU5c
	n6AL/2HFKM8EKlwK3cIgdZEO6ZyW5uj87CWE8ABdPM7hY5a+afjhsvzX9xBV22Mf/o54eDg==
X-Received: by 2002:a05:6808:1794:b0:3e0:4133:99a0 with SMTP id 5614622812f47-3e7bc7bc66amr16382b6e.4.1731611549096;
        Thu, 14 Nov 2024 11:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/UJ9X2WjL5AFyWAPl6EYQVm4D+EAWr9fpOXs+H30M0xXdRkYbHQnvY0S8JdsEfPoxb3t5uQ==
X-Received: by 2002:a05:6808:1794:b0:3e0:4133:99a0 with SMTP id 5614622812f47-3e7bc7bc66amr16361b6e.4.1731611547330;
        Thu, 14 Nov 2024 11:12:27 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b8599703sm561728b6e.1.2024.11.14.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:12:26 -0800 (PST)
Date: Thu, 14 Nov 2024 12:12:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v15 0/4] debugfs to hisilicon migration driver
Message-ID: <20241114121225.3ab59ce6.alex.williamson@redhat.com>
In-Reply-To: <20241112073322.54550-1-liulongfang@huawei.com>
References: <20241112073322.54550-1-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 15:33:18 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> Add a debugfs function to the hisilicon migration driver in VFIO to
> provide intermediate state values and data during device migration.
> 
> When the execution of live migration fails, the user can view the
> status and data during the migration process separately from the
> source and the destination, which is convenient for users to analyze
> and locate problems.
> 
> Changes v14 -> v15
> 	Correct variable declaration type

Applied to vfio next branch for v6.13.  Thanks,

Alex


