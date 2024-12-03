Return-Path: <linux-kernel+bounces-430236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458B9E2E56
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57914164415
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7720898C;
	Tue,  3 Dec 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9QomB6g"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DA1AF0AA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262251; cv=none; b=Hi5CHbOXdO4OkBGDc/FvIN3WceYauf6UU878qqFL6QwWNWFITAI9UXvnrGPsuUYlYBSsY+69hzWYrLCyYxisp3r01B1q0LQ42Ql/P0X2RYh5FHID3+KPoREbwVkpdkJKLQgn2SWjef1XOoc/J19s5Nb6PCxT1MTI7jvfMLF6Knc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262251; c=relaxed/simple;
	bh=M8lK+1HPlaJ9pqYHbJSSDIlCis0xxz6cf5zhCZhoRnI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8omSkXlRnJFE02wohHjj25MRIqf9SlGQeqz6GtvsyCn6G12UQ5AoOilm2C9IthaaVdZWunAgSGzTDXXh7v7gDUfC4/6j7uiwpV1TG/Y+hk5fGO6S7tWK4+S4Yh0owJmkPXLrCbcJxhVeo/LhhSX1zNd8vakFDI2dkecp7OTMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9QomB6g; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso4692672a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262249; x=1733867049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ljDKfb9sr4GSKbj8U3a57Eoz3AQHjiB8wr4Im39gx8U=;
        b=d9QomB6gLEVIyTh7UsRKqEworP+ts7kz9gJUKa8IgObEQz4Z44hLXxe/fLptVqBtxf
         fUd9YrS5LUpjf6PTLjIUatWAVFpawCwBrhSi7rF7y9Zse67xNsem4O76ueNpgdJZCxdt
         Vag/uFEQS7g0X96zKU934gkVGQAQ9OMCScqSTmK/I53a2doXLqvTii6tHW44LV+P6R80
         ML65MwIsU3rJH946aAkfXWDKTTSDwN0L/UARXO2Nh5T/jOEgi97SPH2tYNgp/xdgpA4z
         EDklkMtzdV6gScBJbj9EtwV0grogG+wQz3tq2mggEjILcPkMAVndbeZHN0Bt/+503GkI
         L77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262249; x=1733867049;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljDKfb9sr4GSKbj8U3a57Eoz3AQHjiB8wr4Im39gx8U=;
        b=N9rwFYDM6ehJodDt4SCWPYh5duzsPNSRDyCiKhJUUwkzVq9nj+PYVXq2EnWQ/boqIJ
         evVxOADdGTaO61OSFjuozeJIalWcb2k7swm0mE+d9orV/R4JBTPnN4nzpYS59s+X+CXo
         g/vEccwKZ8ArfgDt3F8hfDp3LggD8G4W/Ydc57fqmqDs6Ghp65u2c3JPivf0GE2lA4X2
         m+EAFSQmtfxRUywEickKPTFkoi9qFZ3RTZ/OLiDcpmfF9cEYI05gkkq/nT/XdLlTYl9N
         41Y8yElNdNQyIngLAFJsFRroyAZUY035oQmGeHGZr9bVuJnTgROCEiG/aG/C8xT+B6Cy
         ETow==
X-Gm-Message-State: AOJu0YzZ7DGWUcyYzFc8ms4GfQZpTnm/Jm+M2zLk880Hzeg7ve0pOyL5
	5l7Nu63xZ+evrtTmqPf3ooGh5w79s1zQ+toJiRQfGUMrK5+DqIjhbu4OHw==
X-Gm-Gg: ASbGnctmm3T4Vdgp6Rz7H8kfAbCloM1K6PgWGnMe/oOIZ6A91oW1P9NdvycGdra1Y0+
	ffen8Z/eeXA/E8rO6plbrxKpiG1Qhom0hy62iwdw6kAchSEr0xCftE7EB/C2yr7xGcPFxB/1HgR
	sTRPlBImRXkKPL2PEXJpcxRqwPsSZR53+ISZ7kbenAN8va5J76bc3DwbzAmqysVtZhWi52o2uQ0
	JeyEdqdreshzLao8rxhTTcBIYNnUh9ySPv/SdTgzzJVQF6HmhQevIaSdoJzHX9uP2V0Dmld4xZJ
	Oof6U2Fuw98900r6KrU=
X-Google-Smtp-Source: AGHT+IFkKVXpKdDqU1JOiYLT32y8HzR+6JWjbD0D1VlZfsvz/CBhh4C9EWoH2N5Ta4jbvXC4ggE9WA==
X-Received: by 2002:a05:6a20:748e:b0:1e0:d380:fe61 with SMTP id adf61e73a8af0-1e165413554mr6036490637.45.1733262249004;
        Tue, 03 Dec 2024 13:44:09 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d3e28sm10242226a12.17.2024.12.03.13.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:44:08 -0800 (PST)
Message-ID: <674f7ba8.630a0220.3641c.1437@mx.google.com>
X-Google-Original-Message-ID: <Z097peujUb-WhU8f@DESKTOP-DUKSS9G.>
Date: Tue, 3 Dec 2024 13:44:05 -0800
From: Vishal Moola <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 1/6] mm/page_isolation: don't pass gfp flags to
 isolate_single_pageblock()
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-2-david@redhat.com>

On Tue, Dec 03, 2024 at 10:47:27AM +0100, David Hildenbrand wrote:
> The flags are no longer used, we can stop passing them to
> isolate_single_pageblock().
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

