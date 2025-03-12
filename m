Return-Path: <linux-kernel+bounces-557857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE37A5DEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE583A22CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4124BC1C;
	Wed, 12 Mar 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFpeO10C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9722DFB4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788576; cv=none; b=iqMipXkiZfvE2hlwTF47kxn+lUJuovwK5KZBWDOb/D8q48rl/s+K+ZSzbJdoKYdK6dZyfs4ORiTL5PJKlGYOJi2qNJZJ2UsqmKOEmpWVJZnG/J6otdjwoO3ToY5SLyeFXpc7+5EanNcU6Xl2GN0Sr1y0EHC53VU10mHoR+Z+DEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788576; c=relaxed/simple;
	bh=WOtEqvsTAlWvvP5rpIOeUjc+MqZj+OxBToAOp2fiQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgiU3ys9e8o77IlrNzW1UoZCyx3QU4JSGXqV6t5LriXh6YiQtVSNYmv4wmkA4QbMrssNPw0nq51h/GLfZJSF9UFSHMPWVQMjj95v4wIina2EY86GhWXYgxrQrxyvn8Bznv8au8MD85biUBEa5P4DghHjdI7pFSRocXfTYg4GbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFpeO10C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741788574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJ4Bp2vaPkKMLBIs0XU/8MrkCeKduDmY2mvsnVWvGk=;
	b=aFpeO10CRyrPR66R2Jno3BROrfdi3v6VdRfrstN+uF6qhzZbkTKIo3VblcMT+anNNCrmMm
	fMlbYrWk2wh86sn/WbuhU96FhSQwMzeCwHBA1bWG88DbPmX9Km/ctt+teygdixnodSyHiV
	eDFX0fowzyqDRGkZrZNYpFXQCv72d5g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-dhtiEiVbPvulbnmBjEoPVA-1; Wed, 12 Mar 2025 10:09:33 -0400
X-MC-Unique: dhtiEiVbPvulbnmBjEoPVA-1
X-Mimecast-MFC-AGG-ID: dhtiEiVbPvulbnmBjEoPVA_1741788572
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c53b4b0d69so1268257385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788572; x=1742393372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpJ4Bp2vaPkKMLBIs0XU/8MrkCeKduDmY2mvsnVWvGk=;
        b=f17Ouw81Hlpp0k1OUAtP/DE4DBzDYTzKd8ITt1AuKNcK3JKOXutFLheKst68sYSgvs
         yMMH1SmpypGJ0DfWjiQExZ760jWm4B8OfNTOwHSnV3RpqqAxRGa6SDyTLtoH2VeKqaDR
         EHF2TVR4+XffsuQcsHN45BItHpOSnDy94ke0dgG/ziM1fRTlpQQ6br9zFSOm+KgYoJc0
         UAkZId+EWrJQEZ21x/W14czkHG1QP4tmmPUY9dh6wUf70X/kXRhgQ7Ml3EwpU2JCE9kW
         4BEijUvzto81Ly7CFjx0rUvgcYWrSu7odAieXYZg4VrdaOEExYUcG2nNIanvhE1hiXVI
         jhQA==
X-Forwarded-Encrypted: i=1; AJvYcCVo0xSuG+R9swwyW/WmkKXO0qUFKPciDVoNlgxd0/SxQO8lOZ5E9VPpKkuPBHkgYhSYm9gKYz4Itb01Zhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7m3NGgkyBHx8WOmvX6pMc5kke2BcP6g9aGUK2GgGXc7Wyiott
	YlKTtcIqs4mDfs3jIhmZ5Axu8VylxUHBlQcSn4o9Ss2hCCmPTw9xxoq1IMdav9NjU1DJV7ox1LS
	ExM0QZQfvPfoHDQ84WpxJNkXaHEFHaTgnBJOQ9HbDwTT5v7G/t/yRLQJozLxM6g==
X-Gm-Gg: ASbGncsidNZz/xaGpSHCsYOMMhzpjvZZyUf30zSpCy1BsGQpZEqXaKEh1g6HcenqYDn
	YUQu+uvXHwgzLCB9gW3vu4zozMChLPODzAbHcdpUVqvyVdBAVZXogQm0x/qcXwbUSlg9EiqpdQu
	r66STVSQ1dK2oLBLEtFca6y07okCgN+OQ89g/HFYCQHwU7A8PDbD2lJBYg/aJxPBxdWrOn/9Rqu
	MEfblNlSvD1rfrmp2OMRtA8DzNPaPLUoArnkpPQnQR6rFxENxc+gdESLYWq5cTshdxsBD5d9qmn
	vc3r+tI=
X-Received: by 2002:a05:620a:1b85:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c54b244796mr1835005285a.2.1741788572685;
        Wed, 12 Mar 2025 07:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVAVnFr8TuudXs0D2kTM0FEywRnFo1M8MBCogN3k6/Xg3Qw7mBw/qIldth+aY3HnE9WFX8Q==
X-Received: by 2002:a05:620a:1b85:b0:7c5:4b24:468d with SMTP id af79cd13be357-7c54b244796mr1835003585a.2.1741788572459;
        Wed, 12 Mar 2025 07:09:32 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c53c07b645sm727548385a.77.2025.03.12.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:09:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:09:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: jimsiak <jimsiak@cslab.ece.ntua.gr>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <Z9GVmeHJSftfQPPF@x1.local>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
 <Z8t2Np8fOM9jWmuu@x1.local>
 <bb6eb768-2e3b-0419-6a7d-9ed9165a2024@huawei.com>
 <Z880ejmfqjY1cuX7@x1.local>
 <bb6bba1d-fabe-cc14-2521-ffbf2e31ac63@huawei.com>
 <20a6b1c1-389e-b57a-7a5c-d1b0a7185412@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20a6b1c1-389e-b57a-7a5c-d1b0a7185412@huawei.com>

On Wed, Mar 12, 2025 at 05:18:26PM +0800, Jinjiang Tu wrote:
> Since this patch works, could you please send a formal patch to maillist?

Will do it later today, thanks.

-- 
Peter Xu


