Return-Path: <linux-kernel+bounces-550232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C261A55CDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D592188495E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0146152196;
	Fri,  7 Mar 2025 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4Oe3F8S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AB19048F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309957; cv=none; b=rWBnPfE7R7GJKOgJeMOjwBCBrVL0TVuQ9ORbVnEfUKyobBZ/cI+9QaCSej7cReSPzx9hp1EmZI8qYXYWTceq14MN1kiA6RA4SBdfZDT6feEAyI18sCQ+ZMOv37Fsg6sEVmiB53tAhetNu0o0Bo9ZdgebGniLTSNH9bTxA/a7x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309957; c=relaxed/simple;
	bh=i4e1Wq5wULsJ+Sd1+XzXR5DjN2FAixSujA0TvULCFcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNxKqMfHwnhhHvU+tHY27Fbun+cBwKDrQzJB6vR+K+GFrXcpXD6nQagOVkwUreG0OW1enEVJlwAqZJVBO8YVgE0FXiW7QvWbwgUkMDrgnxsqyvRx/ySrph7l4U31vZgNw0dx3Yo8aZELZFGAjyOp0AoRf59e5YeFbuTm5NV2nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4Oe3F8S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741309954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mdzK/WXp+Lm7i4d9GJMs+rpGzUg0HU1Yazr+QOg/6E=;
	b=L4Oe3F8SQPK0+qWeLBKuwR7oRsuq8HHovKsNzsotNbcf5xfX3SCRmSgnykzpJVSQOIqWGv
	1VdYKI6xI0Wu8EvNz3ItbXIfLJUe2Rblu1GY9v1lb8QV0qDaAx09wrAE5SQ3i71voxUl17
	PXKJBBNuFv15HaKM0YGf6+4pr1Fmvpg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-so212BznPymnaZOowrfQvw-1; Thu,
 06 Mar 2025 20:12:31 -0500
X-MC-Unique: so212BznPymnaZOowrfQvw-1
X-Mimecast-MFC-AGG-ID: so212BznPymnaZOowrfQvw_1741309949
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75608195608F;
	Fri,  7 Mar 2025 01:12:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C35C7300019E;
	Fri,  7 Mar 2025 01:12:25 +0000 (UTC)
Date: Thu, 6 Mar 2025 20:12:23 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <Z8pH97tbwt7OGj2o@madcap2.tricolour.ca>
References: <cover.1741210251.git.rgb@redhat.com>
 <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 2025-03-06 16:06, Jan Kara wrote:
> On Wed 05-03-25 16:33:19, Richard Guy Briggs wrote:
> > When no audit rules are in place, fanotify event results are
> > unconditionally dropped due to an explicit check for the existence of
> > any audit rules.  Given this is a report from another security
> > sub-system, allow it to be recorded regardless of the existence of any
> > audit rules.
> > 
> > To test, install and run the fapolicyd daemon with default config.  Then
> > as an unprivileged user, create and run a very simple binary that should
> > be denied.  Then check for an event with
> > 	ausearch -m FANOTIFY -ts recent
> > 
> > Link: https://issues.redhat.com/browse/RHEL-1367
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> 
> I don't know enough about security modules to tell whether this is what
> admins want or not so that's up to you but:
> 
> > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > -{
> > -	if (!audit_dummy_context())
> > -		__audit_fanotify(response, friar);
> > -}
> > -
> 
> I think this is going to break compilation with !CONFIG_AUDITSYSCALL &&
> CONFIG_FANOTIFY?

Why would that break it?  The part of the patch you (prematurely)
deleted takes care of that.

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..d0c6f23503a1 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
-extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
+extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570


