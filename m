Return-Path: <linux-kernel+bounces-186364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1B8CC339
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3981F22FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAE141981;
	Wed, 22 May 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dnjnc1lM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875C3C0B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388043; cv=none; b=PA9XZtKC+crFe1tawDhHvz5YmTnyrb4HDZlVXe/Nx9DLp3FEGnCDkramNz/Ozmssov3ehpxqvo9Bzi/CjBAYIe4Q+0fudPjrkJsemtqpRUMDdhKLQFZxt4JZrSW3ej2Ot8oK2gRt4f4psfPUCI5V0oM4DzAcZ/HA66hdPFT1yiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388043; c=relaxed/simple;
	bh=9Fn0WfEjx52+1QRb1yhDK//ABaUvIK47riUAZlHyIpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvEQtky9dd2DDF9Fl2zH7sjakxtAsyTMwI1xjOZ4IIBWlpfiSkTmQwQAJsW1Ice2Wz82/X2bPtyYh/7z87KeccxbBzqoa2MbJYibsioTWt7DcaDq1ZoY6Feye5B4IoKNWt0+BeD7TVRZhTrw3LS98IAmhxTkbf+inWN1A6GcPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dnjnc1lM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-420107286ecso72835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716388040; x=1716992840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWS8Vu4y++22wN7Iqs/67qvIcKnj8YVwi65a4fpgdVM=;
        b=Dnjnc1lMgWAHA3E4Gq6K2i9J73GsRf0fI0xlR7nDOZRedjX3Xa7n22lbk59hzYHzBK
         t/tZxJia1bW/6XmmWkAbnf7IgtuIfkCtOhAIhQibMQWzWlzPzOzEaUuhJeoRHicURTAR
         8qGf9t+hOBnKKjnMTXI0T8FNmEE18fftZWGnIBTQ4OHT1pVxGVCTa45DAWEgs0gDArbv
         5tM6Fb8R6T8Md8WLNODwLSjwY1UULc6fQMHkmRYzSAQ4Ga9if912wDqbR/Urk0JK2dvz
         Zh3vk+tdbYgcBOHvT9DFKnhKE7BQWHRkDfABoutx7V0sRFW9hTy+TY9UKPRbG6TE0iEH
         p2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388040; x=1716992840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWS8Vu4y++22wN7Iqs/67qvIcKnj8YVwi65a4fpgdVM=;
        b=JJjgCAF0JPe2L/kjHkX3e+0qr/Z3wLQVmxkSoH6Y8a0vNihiYqrIBMfy+PWdCr8tZ4
         F8WzGyQnOjg+I7RRT30rs35O28iXQUbB+P45sjD+vnI/vyY8oo3/qsgSnw3qUexKAPIC
         lEPCS7pnR1ysFNI1exVDtKREycSNyhK4G6LmL3GXLnAhmTkKK7ZI9uMNS2QmX8n4Z6to
         gLSHz7v5Wln+FeWNsMNDyyWp5uDP7z/n/Jt+rRvsUT4Y+/DtSkjCcwXJUp4m4XAB4/dm
         bCZ0zOYrR3/Zt9wOiTUyAaoniJlopK+HHzod3AB4VAsOViyesWzI9+aHc5kXmy99MhwA
         npnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUntNx6kf3Z03LXHtJOibP4Fe+1QKaC9cGZDB+eMsH+BVCY2R6g6Ja1tY0XR3WAUrXxDVxTMgLDdbafjCDGEXVkp1FjCwg7zCleLsVW
X-Gm-Message-State: AOJu0Yyqbm4RwbD67aDkdeK8hK7D6FBs8N0+0h7v9aDD0tcbGjef53hp
	DNntfMPF+SQi3JozT2hJcMqnhXrOagIRJFF1gAe+ou7G3/bv93vUg6c6uSpDl1cqP0vYllwkRId
	OqQ==
X-Google-Smtp-Source: AGHT+IEFFG+qYQVoC2KEMboKeDlm7788nvC7Mqu7vzSmsup678qTPNKe5/p4J9YO3Lr0CHgF9wFRcg==
X-Received: by 2002:a05:600c:cc4:b0:41c:a1b:2476 with SMTP id 5b1f17b1804b1-420fc8135e7mr2037165e9.6.1716388040011;
        Wed, 22 May 2024 07:27:20 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354de2d1ae0sm1576149f8f.44.2024.05.22.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:27:19 -0700 (PDT)
Date: Wed, 22 May 2024 14:27:15 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm,memory_hotplug: Remove un-taken lock
Message-ID: <Zk4AwwX7x426KU7H@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
 <78e646af-e8b5-4596-8fbf-17b139cfdddd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e646af-e8b5-4596-8fbf-17b139cfdddd@redhat.com>

On Wed, May 22, 2024 at 04:09:41PM +0200, David Hildenbrand wrote:
> On 21.05.24 14:57, Brendan Jackman wrote:
> The old seqlock guaranteed that we would have obtained consistent values
> here. start + spanned_pages defines a range. For example, growing a zone to
> the beginning implies that both ranges must be changed.
> 
> I do wonder if it might be better to instead have zone->zone_start_pfn and
> zone->zone_end_pfn. That way, both can be changed individually, not
> requiring adjustment of both to grow/shrink a zone at the beginning.

Thanks this is a good point.

So basically the fact that spanned_pages is "once or eventually"
correct is certainly not enough because it only has meaning with
reference to zone_start_pfn. I didn't realise this because of my
spontaneous inspiration to believe that zone_start_pfn was fixed.

By the way, some noob questions: am I OK with my assumption that it's
fine for reader code to operate on zone spans that are both stale and
"from the future"? thinking abstractly I guess that seeing a stale
value when racing with offline_pages is roughly the same as seeing a
value "from the future" when racing with online_pages?

Also, is it ever possible for pages to get removed and then added back
and end up in a different zone than before?

