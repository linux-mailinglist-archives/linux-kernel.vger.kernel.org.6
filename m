Return-Path: <linux-kernel+bounces-287733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C4952C06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D72852E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59211BF333;
	Thu, 15 Aug 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PQqMK1mr"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7C1BF326
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713643; cv=none; b=HRkQ2hWKgi3XK6TkammxgdmwmZigIW+Junjn/ChGgmW/CKODhZYVArMHdL82zZydjKohi3dBcpQkHuPKK1aej0lEbI87d1hVHv/9yfv0EIBg6zVw1+57jx8uIGNO+zoI29pRd6GovkbMZbqX93iz2cqDsZ/pHQSbVcLfI9EO9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713643; c=relaxed/simple;
	bh=Wpgw8IAzF7moxyWZ4DLwitTyfGNFshS+sDvJ99wrmk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZLbw1lDnjyZsowhAZ5BAk2Bh3T3TzxXG5ixpTUWNBLx3JnlL1J1873c9tkLMZc25fhQ6Nq2hEU57HQAf3Goe2l5WpDDWShyxGcI1JANozyNhsycmdnkL3VN5csL5lmI1y1CRItFTje7wqfV1F/ekYDfpcXMI6PL5xQ1gDKC8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PQqMK1mr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9e25008aso107631666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723713639; x=1724318439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/GlGs8gPXiljJsbSUC3SWxa6wJC0t8b6kAqnPPHnvg=;
        b=PQqMK1mr2RvXke2WUOPnAVfn9Ns9xGyCf44rGkwWg9UDnf2y9a2XOSt6kPvX59PeRs
         //jMArodzD6ZKMJU+WJrc6CFdhBTD4qUeide4ztTzkKMle+P13DbERcxlCpHEJ2b5gBT
         Ln4XgKtl/CJ3S6fxYvLeFSXPKcWnTJWdXFne4nQSxDbqvthAAe2Yv1OVXFDib/z7+EBY
         cns5KuM7COU0hHYrG1wZFnLDShGtRC4RSKVqiDqMRVj41AWPR6/hm/uaORCQj1nEkYr0
         IvncxvF6igp6kEhCDJgSRWmTdq0y0vCYESL+DSUtKqRv6q5ET44Yq6yu5FExsmL9Z+QV
         j1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713639; x=1724318439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/GlGs8gPXiljJsbSUC3SWxa6wJC0t8b6kAqnPPHnvg=;
        b=T9uhtQ8cPsPFpB22JvfOsmB5h5ignEvxEipeuh2nE+LHPpOM+6WrDXHxVAhNJFKev3
         UwTqr/XtX8sGCenxTia+9NnlbzRe+r+5UCf7ztiHx+jmIAP2KYbVdicL2vOsnEUkRG1r
         k0mCy3cTYkL6+klg/wdthcGBVyp+RjDOzJxqQLftuxBiulFTcu6wef8YcBcj1O4hjQ2w
         RUh98mtWwhwFu4547W7flPC38tVOn/5CcC20fPs+nNc6iq7DerKAMpr0UpA5b1juosfN
         xbWZX+Gl2+fDUtH23SZjlAspMX2wNIUo9eZD8AS3gQpMqfmAxCk1+Xb2tiYVyzOMr3ok
         LMLw==
X-Forwarded-Encrypted: i=1; AJvYcCXUpJPrqdx0AleZhcw6KFnUKOUgGx6TO5r/t+e8Awb4trSXPZUEQuXbBk+CdZmYgsm+cnc55bwEp1Q++4awv8Sw+CT1oue/htInMK+9
X-Gm-Message-State: AOJu0YzHRSy96LplP/iY//CvwZ5Zpzf2lNqiEmsNW+bdTGPpFL1/wQCP
	9L9RcapNOxpYrfY5RPKW0Nz/Pvbndo90+sG5qkDTiGxc58YbYW5Ibu6UZOytucA=
X-Google-Smtp-Source: AGHT+IGIf0tHUTHAiN975hHhh6Mp8xXyGrE4WwTVPMNfJW1nQ1v4meDulrazycZekuiqSshjepPOHg==
X-Received: by 2002:a17:907:1b19:b0:a80:f840:9004 with SMTP id a640c23a62f3a-a8366c1eca6mr410252966b.12.1723713639259;
        Thu, 15 Aug 2024 02:20:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946967sm72340166b.172.2024.08.15.02.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:20:39 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:20:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] livepatch: Add using attribute to klp_func for
 using function show
Message-ID: <Zr3IZTGnY-e-SHPy@pathway.suse.cz>
References: <20240805064656.40017-1-zhangyongde.zyd@alibaba-inc.com>
 <20240805064656.40017-2-zhangyongde.zyd@alibaba-inc.com>
 <ZruEPvstxgBQwN1K@pathway.suse.cz>
 <0BFE862C-BD2B-43D1-B926-11A48BBC8C1B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BFE862C-BD2B-43D1-B926-11A48BBC8C1B@gmail.com>

On Wed 2024-08-14 22:23:21, zhang warden wrote:
> 
> 
> > On Aug 14, 2024, at 00:05, Petr Mladek <pmladek@suse.com> wrote:
> > 
> > Alternative solution would be to store the pointer of struct klp_ops
> > *ops into struct klp_func. Then using_show() could just check if
> > the related struct klp_func in on top of the stack.
> > 
> > It would allow to remove the global list klp_ops and all the related
> > code. klp_find_ops() would instead do:
> > 
> >   for_each_patch
> >     for_each_object
> >       for_each_func
> > 
> > The search would need more code. But it would be simple and
> > straightforward. We do this many times all over the code.
> > 
> > IMHO, it would actually remove some complexity and be a win-win solution.
> 
> Hi Peter!
> 
> With your suggestions, it seems that you suggest move the klp_ops pinter into struct klp_func.
> 
> I may do this operation:
> 
> struct klp_func {
> 
> /* internal */
> void *old_func;
> struct kobject kobj;
> struct list_head node;
> struct list_head stack_node;
> + struct klp_ops *ops;
> unsigned long old_size, new_size;
> bool nop;
> bool patched;
> bool transition;
> };

Yes.

> With this operation, klp_ops global list will no longer needed. And if we want the ftrace_ops of a function, we just need to get the ops member of klp_func eg, func->ops. 
> 
> And klp_find_ops() will be replaced by `ops = func->ops`, which is more easy.

func->ops will work only when it is already assigned, for example, in

   + klp_check_stack_func()
   + klp_unpatch_func()
   + using_show()	/* the new sysfs callback */

But we will still need klp_find_ops() in klp_patch_func() to find
whether an already registered livepatch has already attached
the ftrace handled for the same function (func->old_func).

The new version would need to go through all registred patches,
something like:

struct klp_ops *klp_find_ops(void *old_func)
{
	struct klp_patch *patch;
	struct klp_object *obj;
	struct klp_func *func;

	klp_for_each_patch(patch) {
		klp_for_each_object(patch, obj) {
			klp_for_each_func(obj, func) {
				/*
				 * Ignore entry where func->ops has not been
				 * assigned yet. It is most likely the one
				 * which is about to be created/added.
				 */
				if (func->old_func == old_func && func->ops)
					return func->ops
			}
		}
	}

	return NULL;
}

BTW: It really looks useful. klp_check_stack_func() is called for_each_func()
     also during task transition, even from the scheduler:

       + klp_cond_resched()
	 + __klp_sched_try_switch()
	   + klp_try_switch_task()
	     + klp_check_and_switch_task()
	       + klp_check_stack()
		 + klp_for_each_object()
		   + klp_for_each_func()
		     + klp_find_ops()

      It would newly just use func->ops. It might be even noticeable
      speedup.

Please, implement this in a separate patch:

  + 1st patch adds func->ops
  + 2nd patch adds "using" sysfs interface.

Best Regards,
Petr

