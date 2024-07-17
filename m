Return-Path: <linux-kernel+bounces-254807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB99337F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CB01C223E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB881BDD0;
	Wed, 17 Jul 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YCnaztSI"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363F11CA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201152; cv=none; b=jL7iKnXK2lhkrASiDOzFxCreYmtUpCv+FCBB9qIjbcEaFNoI42/vw5w4eeN+6N9G3aIIw+ztEw4QbmEI8Sgtj9leKSVYm6p9pjXG8sYy96N8LbNJTXAqTl6xGOggDfpeG78aHJd/u4LlOBBGj0g7rakspsc3dRhPXRwBLvkKjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201152; c=relaxed/simple;
	bh=9GXlpVhYdMJeST/vqSv18+O22GdEPUoIU0h81DQcFNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcJjJRFs5FbFFTrUrBXUfHiqNZ9jSEJQqzgI7+22lbSI/dpoG9VGX9gQh3V4SlCEyxEjZHIupNJ1Gvxg7GZuAhPapzwdWPuEAVEhiWFHU7fylTTACofxY2KIXqNbCzEpf0+LwVolk1V16OX0PSXAHFTdmyVz/FFkq8ax63V1MHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YCnaztSI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso8419732a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721201148; x=1721805948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyNEJ2CjDStmZXq/bezWo1H2BjnQ1NOltp+UcNHYMQs=;
        b=YCnaztSIvB3s6HZ/u88JfuMQ3c/Xux4c3mkIz56JeNBQzGlPgm19tdMG/cRHbhcs5C
         1/bFKaC+XNAnPnMpWz+yVpCLGv2EVJtdNAlPULeQxoobtLHfqCgyIxvF4UnmSBDTKklZ
         a43d9sYvPDhQOiVnzb8wcVdXfLhkhtvWeD/qhEUEfxcqWywu+0u96hRCy2KHzpVtVjCE
         vBEaCxnJN43oUtjTAsASFKZZyPvRTtKwlf1rlwtmvclWswkXGHoy5BIZDIZ1/agbWNSg
         ZXH/ITTdjao62S3IEMIlE6j5AOX2BCT5wZ4LVu1lZSWXDzZIlhiW9juLk0/md7OX/yyy
         J1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201148; x=1721805948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyNEJ2CjDStmZXq/bezWo1H2BjnQ1NOltp+UcNHYMQs=;
        b=gUQKi+wocQ6zzERdTe7Jkp2m99JqT+EnKTagPBE9NYYQgIqi6i8sAwyzXPLB1w7qmF
         iL+w1jXE+OslGlI36S+GHf4zelRmQV4bBOGJIhRl4tXS8c7KUJUizZIrt1Si5tqcmZ0f
         jX0G3SF34WxjwmMo+gFlcPfqne++PehD+4mxjaLqt1NWwZys2+39wNo1smZ1KcMtlFme
         Os5Ubhu0rlUSevfpaNliLkKYy/ibRIKBEtukqbpzUdbEM+8LQILw0UQ4umdI0b14m1g8
         EosVTFwx6yAC5tw2aKzvWWDlrPnYR3MEHx6csV1CGL/olihtudbC3yjCqx2GGg1GWaQe
         5wOg==
X-Forwarded-Encrypted: i=1; AJvYcCUWPxJuxOIVQt4aIQnC+XDFNlS0SVLuuBEeXDNZ1z8vvYhfVQTIyvX7fJOQ++ET0mtLU1JeKr0Q52ApsoL6iot+za7PsdM+npNhNTjL
X-Gm-Message-State: AOJu0YzG3YdmQRuuSxKXyyfnm9rm3+wan40cr9dVsz2+QlEoX6ZBHCu9
	QlviW99G06JTlG8HWubdGkWUYKGy8v3kwHGfiABBkGpvp/xPQkJVZ+gpxCeYDm8=
X-Google-Smtp-Source: AGHT+IHldCA0Kvfuc4j9iOIsN2k2QfRHmmcKeV/g8sdl2YYZp2EsSMhCl/uEN0fFPMPtavMAZ+Jv+Q==
X-Received: by 2002:a17:906:234b:b0:a77:dcda:1fd8 with SMTP id a640c23a62f3a-a7a01153ed2mr49492366b.23.1721201148159;
        Wed, 17 Jul 2024 00:25:48 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc800056sm423308866b.174.2024.07.17.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:25:48 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:25:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, nao.horiguchi@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
Message-ID: <Zpdx-smohyWI2nYV@tiehlicka>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
 <ZpYxkH1EFB65tEzt@tiehlicka>
 <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>
 <ZpdiOAjdSJfkpbr7@tiehlicka>
 <d04b9e4f-fc43-f93b-c1a2-2ed9479ffc71@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d04b9e4f-fc43-f93b-c1a2-2ed9479ffc71@huawei.com>

On Wed 17-07-24 14:59:40, Miaohe Lin wrote:
> On 2024/7/17 14:18, Michal Hocko wrote:
[...]
> > Why does this need to be done through different modules? Why it cannot
> > be part of the memory-filure.c?
> 
> This is a bold idea for me. :) I think it can be part of the memory-filure.c.
> So CONFIG_HWPOISON_INJECT should be removed from the world and then make
> hwpoison-inject default on when MEMORY_FAILURE is configured?

I would start by moving code into mm/hwpoison-inject.c. Whether this
should also remove CONFIG_HWPOISON_INJECT is a different question. I
am not really sure a debugfs interface warrants a config option. Anyway
two things for two separate patches
-- 
Michal Hocko
SUSE Labs

