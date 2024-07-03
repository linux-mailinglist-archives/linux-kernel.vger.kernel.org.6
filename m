Return-Path: <linux-kernel+bounces-240138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA4926981
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C9B25555
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B818FC82;
	Wed,  3 Jul 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3th4mra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4218C333
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038247; cv=none; b=X/kWpCvPLOUKgmzDF5XSMcn92ip9i+q+zm0LCqg05i9SLZlVM/jBEQ/BBIxqY+jaRdM2Uj5ZP/ZOAAxkwXE69iJP4HQcbh6UuqYxjKCMUxkKTEWgLw9MOSlzQ0wcHfFvX/Jgr8dooR9K7T38MEAjzxAlDwFqsU5eqk5ruUliepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038247; c=relaxed/simple;
	bh=0UlD8Lf5gmeNWbx4CG1RAAcF56k5RNI/gmt37Yi6EOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO2AeBy2MpIJQE195ejKTLFGsXVTBib8E2HMbhilq7dxjnZFFRTToGKRELICgMVFiJrYppBeXK0iWG5NXalOU0BEYNcZk0di6fEmad2C0rY68kvWRuPowKwJVjcgoTXSjpyaAYaspTc0ih6UJmQdES58ITs5ck2ivGLBeX2hfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3th4mra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73EAC2BD10;
	Wed,  3 Jul 2024 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720038247;
	bh=0UlD8Lf5gmeNWbx4CG1RAAcF56k5RNI/gmt37Yi6EOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3th4mraJ5wYohSVUko6L2Xf3r0VRH9MAW6zRHd+fWRrQ5F1PjhbTgQZjM1ln4cL9
	 oYXsvWBxe4XaZFR/ixxxS5QfGGrggRYK5ZQhKHCX6zjBQs9lGj8gqxeq9y+FMc5ZbM
	 Eh69tmX8pKkOquXnUyiET5TQjotihoBE4mKTpjdm2x3Xhtf74mwcHqFXIFo0+UUw6+
	 Sz5XAi/MtfkEWyzMw9phlHtXSWWMDmF6eRruAoUZOgRhPIS0UGQLISFV06oHY5a0rr
	 /Fawqq6lr0gzjQpK9zSRquyfT9UCbiGEOh3vZJ+JcRgadfCAxFeEn9SQdGF7pZc1jB
	 tgOK+Irwa5YNw==
Date: Wed, 3 Jul 2024 13:24:06 -0700
From: Kees Cook <kees@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2()
 macros
Message-ID: <202407031249.F9EB68A@keescook>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-2-bvanassche@acm.org>
 <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
 <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>

On Mon, Jul 01, 2024 at 09:42:50AM -0700, Bart Van Assche wrote:
> On 6/30/24 7:51 PM, Lai Jiangshan wrote:
> > On Mon, Jul 1, 2024 at 6:29 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > 
> > > --- a/include/linux/workqueue.h
> > > +++ b/include/linux/workqueue.h
> > > @@ -525,11 +525,20 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
> > > 
> > >   #define create_workqueue(name)                                         \
> > >          alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
> > > +#define create_workqueue2(fmt, args...) \
> > > +       alloc_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM, 1, ##args)
> > >   #define create_freezable_workqueue(name)                               \
> > >          alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND | \
> > >                          WQ_MEM_RECLAIM, 1, (name))
> > 
> > Is there any possible preprocessor hack to avoid the renaming of the functions?
> 
> Thanks Lai for having taken a look. As one can see here the last patch of
> this patch series renames create_workqueue2() back to create_workqueue(): https://lore.kernel.org/linux-kernel/20240630222904.627462-1-bvanassche@acm.org/

This can be done with the preprocessor to detect how many arguments
are being used, so then there is no need to do the renaming passes and
conversions can land via subsystems:


diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb3993894536..00420f85b881 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -523,13 +523,24 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 #define alloc_ordered_workqueue(fmt, flags, args...)			\
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
-#define create_workqueue(name)						\
-	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
-#define create_freezable_workqueue(name)				\
-	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
-			WQ_MEM_RECLAIM, 1, (name))
-#define create_singlethread_workqueue(name)				\
-	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
+#define __has_one_arg(args...)  __is_defined(COUNT_ARGS(args))
+
+#define __create_workqueue1(flags, name) \
+                alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM | (flags), \
+				1, name)
+#define __create_workqueue0(flags, fmt, args...) \
+                alloc_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM | (flags), \
+				1, args)
+
+#define create_workqueue(args...) \
+        CONCATENATE(__create_workqueue, __has_one_arg(args))\
+                (0, args)
+#define create_freezeable_workqueue(args...) \
+        CONCATENATE(__create_workqueue, __has_one_arg(args))\
+                (WQ_UNBOUND | WQ_FREEZABLE, args)
+#define create_singlethread_workqueue(args...) \
+        CONCATENATE(__create_workqueue, __has_one_arg(args))\
+                (WQ_UNBOUND | __WQ_ORDERED, args)
 
 #define from_work(var, callback_work, work_fieldname)	\
 	container_of(callback_work, typeof(*var), work_fieldname)



Now conversions are one step, e.g.:

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index d74e829de51c..f7f27c6f1a15 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1458,8 +1458,7 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
 	if (!info->response_mempool)
 		goto out3;
 
-	scnprintf(name, MAX_NAME_LEN, "smbd_%p", info);
-	info->workqueue = create_workqueue(name);
+	info->workqueue = create_workqueue("smbd_%p", info);
 	if (!info->workqueue)
 		goto out4;
 
-- 
Kees Cook

