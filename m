Return-Path: <linux-kernel+bounces-284538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D895021A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31A12851C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C4189BB7;
	Tue, 13 Aug 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qsAGM+/0"
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF213BADF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543772; cv=none; b=TB+I+L5w7A5JOw8SqKsjP0eN1U6FGOxwdep/osirCNeyk9fW1bnm15Ykh4XmRhnT7/24ZAY1LdBJfx/uHG9zkryyg+fLiwBVKZkJ1r3a5KtgJUUHattzEJXsK28cW205zIVtpuNFfo9+ezs6y58Bgt+YdoD5Nx84m2RpTJwsj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543772; c=relaxed/simple;
	bh=JtIGOIfEY2J5+HBYsOLJeZbv7srucT4gvTbpsHqH1js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrdNDNx2A9TDNlg2vsV+hcCzIeWSnohigOiyos4HxACzHA2f5d+6K4lcYBpMISftJTSH5VgwVu6QqHoBIqA5Lpd1AxIu0DT8OF71lwykthQj/U8KcgYpmcebNSEBJbxGexHsv1KVB4BksSwkyxpuNzvrbK6iuHoYYRyTCvPWE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qsAGM+/0; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WjnDP3HxZzHlD;
	Tue, 13 Aug 2024 12:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723543765;
	bh=BvkxhLSfP0GLpl/b5SaDUQzyCrdpCwqRP9YOE3sw4cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsAGM+/0bA96YKHhFPmDzMqqJdgNJHZB4TyLk1rnFwJNOAEpwAAi4fNU5HddTwIMW
	 SDzuGAwoD/NPuRzOzgO2KcBCCBQZ6SJFTJYdynTsWi2PdRYTFgiZqpcogwCrSAE74O
	 6i2zNmfoyAF12QwGuM9cLfrfVqnaniWVILgpJ7Kc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WjnDN6HWTzDXr;
	Tue, 13 Aug 2024 12:09:24 +0200 (CEST)
Date: Tue, 13 Aug 2024 12:09:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook
 inconsistencies
Message-ID: <20240813.iidaejohj5Oo@digikod.net>
References: <20240812174421.1636724-1-mic@digikod.net>
 <o6ptrfa7gjdukphqtp6dakq3ykndrjusuhi4fyvpc5ne6amcig@lqbdb2dg7yzv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o6ptrfa7gjdukphqtp6dakq3ykndrjusuhi4fyvpc5ne6amcig@lqbdb2dg7yzv>
X-Infomaniak-Routing: alpha

On Mon, Aug 12, 2024 at 11:45:29PM +0200, Mateusz Guzik wrote:
> On Mon, Aug 12, 2024 at 07:44:17PM +0200, Mickaël Salaün wrote:
> 
> No opinion about the core idea, I'll note though that this conflicts
> with a patch to move f_owner out of the struct:
> https://lore.kernel.org/linux-fsdevel/20240809-koriander-biobauer-6237cbc106f3@brauner/

Thanks for the heads-up.

> 
> Presumably nothing which can't get sorted out with some shoveling.
> 
> I do have actionable remark concerning creds though: both get_cred and
> put_cred are slow. Sorting that out is on my todo list.
> 
> In the meantime adding more calls can be avoided:

OK, I'll add that in the next version.

> 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 4f03beed4737..d28b76aef4f3 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -66,6 +66,7 @@ static inline void file_free(struct file *f)
> >  	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> >  		percpu_counter_dec(&nr_files);
> >  	put_cred(f->f_cred);
> > +	put_cred(f->f_owner.cred);
> 
> 	if (likely(f->f_cred == f->f_owner.cred)) {
> 		put_cred_many(f->f_cred, 2);
> 	} else {
> 		put_cred(f->f_cred);
> 		put_cred(f->f_owner.cred);
> 	}
> 
> >  	if (unlikely(f->f_mode & FMODE_BACKING)) {
> >  		path_put(backing_file_user_path(f));
> >  		kfree(backing_file(f));
> > @@ -149,9 +150,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
> >  	int error;
> >  
> >  	f->f_cred = get_cred(cred);
> > +	f->f_owner.cred = get_cred(cred);
> 
> 	f->f_cred = f->f_owner.cred = get_cred_many(cred, 2);
> 
> >  	error = security_file_alloc(f);
> >  	if (unlikely(error)) {
> >  		put_cred(f->f_cred);
> > +		put_cred(f->f_owner.cred);
> 
> 		put_cred_many(cred, 2);
> 
> >  		return error;
> >  	}
> 

