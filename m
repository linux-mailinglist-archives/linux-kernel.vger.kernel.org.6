Return-Path: <linux-kernel+bounces-435167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F629E7342
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CF5289E68
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2A207E1A;
	Fri,  6 Dec 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8wjMHcl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC13152160
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498285; cv=none; b=FL0gz2LJsR6EKzLoMg07IOpnHCV75F/vnvjFN0aZlBGK/27cQm1AE2D2Zlbe6I+aXVkEdwxAHkHqSzAoS3M1JJl+Ynjofdbax2nIPXfuz7UNHxLx+wqT9E7mNGsbNCiLYDB0e2/N1ZNu1xaOvYuDDP6SzdaLRrehY8tcIgEhclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498285; c=relaxed/simple;
	bh=M6n7gPD47dzEJe0d8hoe4pDtgbueIbnYzY7yUOviywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScB/Qeh/PbBsA0fqJuMrBo79+NGc+gRfIQSMfiJG88imvFut2RXI173550PzpT3VJLfIwlkDtY60PFKhZ/QOhQmtlGFpRDgYqBeiMVgbxyruRHf9DQGyKa4QJ67f5KOnLqDk/+sCmAl+j3pO53qGJA6Nfq3yTgCtYFEb0NIyVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8wjMHcl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733498282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKtDgslHIZKXRNcgKxnSMRYZ3DfiXrsFNAN0u9Bq20k=;
	b=i8wjMHclAJdAhYeMy6HSoQ5AJ6JFhyJDITBfXE5pNlIKCT+HTr37kOZGekkZxGGEpK1/MI
	K+nTda49UuQ4x8WVULcgmSDyUQbkBoLJvecIG/OZ2rFEyUkJHAIlCoPM2Acc/4DthsLQDd
	axd2ne39lS4JfUXyor5XhX4x7vx8GK0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-qX_FQXSmMAm8oFoqnvoFrg-1; Fri,
 06 Dec 2024 10:18:01 -0500
X-MC-Unique: qX_FQXSmMAm8oFoqnvoFrg-1
X-Mimecast-MFC-AGG-ID: qX_FQXSmMAm8oFoqnvoFrg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1DA01955DB4;
	Fri,  6 Dec 2024 15:17:58 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.13])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B7D919560AA;
	Fri,  6 Dec 2024 15:17:56 +0000 (UTC)
Date: Fri, 6 Dec 2024 10:17:53 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, eparis@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] audit: fix suffixed '/' filename matching in
 __audit_inode_child()
Message-ID: <Z1MVodP9Xien/Dv8@madcap2.tricolour.ca>
References: <20241122121843.641573-1-rrobaina@redhat.com>
 <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
 <CAABTaaBQ0+tSx++xYB2NJ=3Qkein9Y5=eY0uU-V9Qb6mR28GvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABTaaBQ0+tSx++xYB2NJ=3Qkein9Y5=eY0uU-V9Qb6mR28GvQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 2024-12-06 10:00, Ricardo Robaina wrote:
> On Thu, Dec 5, 2024 at 9:22 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Yes, Richard did provide a reviewed-by tag on the v1 patch, but v2 has
> > enough changes that I don't think we can reasonably carry that forward;
> > of course Richard re-review this iteration and provide a new tag.  I'm
> > going to remove it for now.
> >
> > Al never provided an explicit reviewed-by tag; simply commenting on a
> > patch is not the same as providing a 'Reviewed-by', the reviewer will
> > provide an explicit 'Reviewed-by' tag in their email.  I'm going to
> > remove Al's tag too.
> 
> I'm sorry about that, I was just trying to give credit to the ones who
> helped. Thanks for clarifying the expected review process, I
> appreciate it!

Please re-add my reviewed-by tag.

> > Other than those issues, I think this looks much better than v1, I'm
> > going to merge this into audit/dev now, thanks!
> 
> Thanks, Paul!
> 
> - Ricardo

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


