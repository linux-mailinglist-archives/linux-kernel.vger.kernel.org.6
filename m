Return-Path: <linux-kernel+bounces-212171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7C905C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520AF1C212B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6C839F3;
	Wed, 12 Jun 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZvAjgiQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13062F50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221649; cv=none; b=okpcZZhWmbto621dqDSC61hbbrgF9wezpPFtCJ4+TtcYwciatHYKdE6P7yAtxOoc6FtESnOB5lqH+KFtGak+0xhcUlaobFrb8lSU1u2Jo9AMoyagtBgXnI5r8WcG56vbCt+0yROwWEKyH0aQwS6D+rojjZDUmNRaZ4FcObKArj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221649; c=relaxed/simple;
	bh=PBL/TEU3DjSBOlA4ZGwb9at01hRR3W0FTMA6ERyOutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMyD0SDl910r9Susekk3WP7UTV2YnWrp57+DN9UrqNiUGWgMwGXy95bXZkh2shaV83ur9PozftBrKu2PM+y9+RBSLkmYX4+WhoYJHqM3TIEqYzJtmbIQq7/x1Z2ikYY1hG0DSNIuBm3nTTzOTRGhGt9QSWrtiNQcWm6xIHBq5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZvAjgiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718221645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NChSDrDZFs6MIHVW5KmNAjBXBpmqSeC9Z8y1fy6uHnk=;
	b=QZvAjgiQQ6tzDVff0bIgjtG3ruOZDh7dYv0W29+dNLH4PoSEpCPvaC4CIZ4tX4frDuHUf8
	Ej++6lfOnTBGule2sHX+XBV/U/h55cPCKf1rHKtI/rHDujHy8m3EVXjKFNNm2jQ3eWuR0f
	9XM7+fPQCB5lXzs5neqQqMPv7tGyps0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-Mze8wmnvOxCZiHlkQwjPDw-1; Wed, 12 Jun 2024 15:47:22 -0400
X-MC-Unique: Mze8wmnvOxCZiHlkQwjPDw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dfa478f473eso38799276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718221642; x=1718826442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NChSDrDZFs6MIHVW5KmNAjBXBpmqSeC9Z8y1fy6uHnk=;
        b=sYjorZouCpFdEHUzs3+4sX6EqZJuxCzHqmv5MgizFIaicc5N8qNsIhGy/Z1/Ml6m1y
         ogdqVcBfcjaVHCPCrYis2BpzKpyQ+y5rsnmJrZgxdDlpThVT269MkeSxnB5fwk3WwzZY
         dgr6MQTD6fWv57uZ1oBnqZU6uIkdTrk9AUzIAxdKEs7e2eceWbUZhP1hiKqQmahRFqTK
         3SIc8lFcvLst5vig3S3s6mCGbyB7MMZLmi0zF+WphAIzJ3eZObZd83el0PI9Cg1Xx3YW
         SRmJ9i6IJp4vLXYQFHND25y8z5MFk289PR81Wxduf++4XugtMVSeZQfS2IRnIiy2FTtP
         nurA==
X-Forwarded-Encrypted: i=1; AJvYcCW1pYfbTdI3pmYv8OWsSY7+081EEYvKwGv4nNlJW30hpXtIvM1YZ/ufw1oYDCT3n64/Tg4aQgRPGC2azlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqya/oaNSgxofY3fg0KNPsxNZeGlJYv/IEyYHNElunGCQalUJ6
	a/z3Jqk8mw71OnF2mZgY3aCIUOjLAuw6Zd0ZgLmv9inG7z2eRsNp0XSRwzu8+FOuerUsdm+abJT
	r2ZJ7qHHxLdrTDLQqM1DvaRY2ehSj8CODtrOqktmlegLSJ01RyEx5kGlpRGTfCA==
X-Received: by 2002:a25:2c2:0:b0:dfa:705c:6e3e with SMTP id 3f1490d57ef6-dfe62d2455amr2349351276.0.1718221641801;
        Wed, 12 Jun 2024 12:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/NZjWL/XewnwBWXM0ARgE6B1DBKt2PB3fFEmrHVSn9NT4tqJ1paRNq44UK0/0zf5T3cQbJQ==
X-Received: by 2002:a25:2c2:0:b0:dfa:705c:6e3e with SMTP id 3f1490d57ef6-dfe62d2455amr2349334276.0.1718221641128;
        Wed, 12 Jun 2024 12:47:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44064755da4sm34321341cf.14.2024.06.12.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:47:20 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:47:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
Message-ID: <Zmn7R7cHU3onWbP7@x1n>
References: <000000000000b7b11a061ab49122@google.com>
 <20240612104735.ee6405d2096236bf18c51a41@linux-foundation.org>
 <ZmnmNkexK5CGacN9@x1n>
 <20240612123005.d5872e92a8f60e8dd459cdee@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612123005.d5872e92a8f60e8dd459cdee@linux-foundation.org>

On Wed, Jun 12, 2024 at 12:30:05PM -0700, Andrew Morton wrote:
> > Looks like this is the same issue that the other patch wanted to fix:
> > 
> > [PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
> > https://lore.kernel.org/r/20240523132139.289719-1-peterx@redhat.com
> > 
> > I had a look, and indeed that patch hasn't reached arm64/for-kernelci
> > branch.
> 
> Thanks.
> 
> I currently have that patch queued for 6.11-rc1.  I'm thinking it
> should have Fixes: 8430557fc5846 ("mm/page_table_check: support
> userfault wr-protect entries") and that it should be moved to hotfixes
> for 6.10-rcX, yes?

It looks like I kept forgetting the tags in a few patches..  And yes, that
looks all sane to me, thanks.

-- 
Peter Xu


