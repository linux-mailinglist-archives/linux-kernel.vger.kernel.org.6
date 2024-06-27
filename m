Return-Path: <linux-kernel+bounces-232044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4E91A216
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC59B208F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEF137923;
	Thu, 27 Jun 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GXQARdIc"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041C12F5B1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478945; cv=none; b=ify8OOTR83MPrYqWAwX9cLyWbRu83Jb9YESW8gsFu+8UjMoATabNEJXm79s3flpbTQACEoxyNO0fHE7xB1a16f5EREnw0dW7pUXY6IWakvFEBq6eVnFiN3gUcHgVR3EzuCQb5wtNF5+3KWs8wcbWpfhFkThs87LygSqclM1/n0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478945; c=relaxed/simple;
	bh=+wZLoCz9v175I1odW/Jt6MrC8GIAQ8V5bJAe0Uh7zeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX8ciqUMuPKGiUaUWC5I+KxEBQa/ABUdHmMlGC9KBFQL97GvwvFAvcDLCW0+wUygaB0SueBEgsHEZMi8yWOvu/3Y0Ak8ebss4sE8fByPvZ4BNfnRMF/9fke4p/qQxOboEy9NlAbPZK1/4PocJrH5xtrz7748lwr2eZfSFdcMowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GXQARdIc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso1552989a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719478941; x=1720083741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5DXNB3XydFPik7mjnkhCQiqV4A6hwgYdlYh8t4XwaY=;
        b=GXQARdIcK3StlEUl2MlsWlfT2dc7WV3xJm9ZnbULxWZDuWzDhiFIg0e42Trpt2y+IH
         qmqFI70uQrfEYbJOI4x7PZW0dUt825jVoobPFfQ42HzVAcqI1cHiqORZfInCFa8qPwO3
         14VP5EzxiQ5AFHq3U9NUfzZoNA6+0yh/qw+vjLokLb4zcY7HY6znek+2ndijBTSkaPuk
         7m90+RxAo7u2oeV4lgkovz6XU+dXDriqQqYqOpdyOymXYMEVTtORZHjH+4buFm8DdqtI
         31gxsYGJPZdHo0Bw9zdqP5GT4SN64k86OmCucOZeNWw8q4PPpaHc58uVdZdvv6dQNXxr
         9iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478941; x=1720083741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5DXNB3XydFPik7mjnkhCQiqV4A6hwgYdlYh8t4XwaY=;
        b=NgSvFp80vg3SjZ1WpVPM7tviuzGV3j7huqal8zqsCAlvrdTAXvFZ1hPQUVlKngWOmu
         Peno46BfrWQNEB8KGrTW2gga48ZapDc5kQXeh7yw58aE+TvqV7QYSMdHWLgy8pzKjW0H
         siuWyptRcJ2y07IVMMN1UMOpTx2ElRIoy43P7WovkQreu+GupUz/xvRX9Hlg69ORrY61
         qPcTIpPxg3Kdpz/dQyS1/Cv1VaV2/Sz8wLRD2cViypyS/7MkWPl/t0BHwXDK0NG8ncib
         LXHIw1o0/6/Nn1AsVlhpRHmquivTnE+TdLp7OBSVZig8m94oTMqklFG1plFXo1fuyhtT
         0Wpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNVWodkCilvp0w9bn3E6z7poNUA9nfOhNrGvRQzJudYmkjZfw9d6HtT1c6Ley1v3cAymGRXCRpztLnryAZjvg9wXaatlMiJ4UpXWcc
X-Gm-Message-State: AOJu0Yyv5WqDU8LV5q7JgPFctjE29oLDgvuNYQh8aIUjxJE8PkXsnkYG
	9v4sh7lyMpOkHS0QBBEwRJVWr52/vhHf/6Mz2A24OIf1pxY6Ho7b7RA0mAs5l2M=
X-Google-Smtp-Source: AGHT+IElyVJG2r0wpz2TYHGnfK4Jsl3jyf0Db2mBM7vuIx5MEshmVOfVftMQgyuT8j6VsmqJuv+1Ug==
X-Received: by 2002:a50:cd41:0:b0:57c:74a3:8fd2 with SMTP id 4fb4d7f45d1cf-57d457a14c7mr8742892a12.21.1719478941146;
        Thu, 27 Jun 2024 02:02:21 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d278121bsm593437a12.61.2024.06.27.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:02:20 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:02:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memcg: mm_update_next_owner: kill the "retry" logic
Message-ID: <Zn0qnFErM9jJVFCb@tiehlicka>
References: <20240626152835.GA17910@redhat.com>
 <20240626152924.GA17933@redhat.com>
 <Zn0bPrHrBGwdrGwU@tiehlicka>
 <20240627082941.GA21813@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627082941.GA21813@redhat.com>

On Thu 27-06-24 10:29:42, Oleg Nesterov wrote:
> Michal, thanks for looking at this,
> 
> On 06/27, Michal Hocko wrote:
> >
> > On Wed 26-06-24 17:29:24, Oleg Nesterov wrote:
> > > @@ -446,7 +463,6 @@ void mm_update_next_owner(struct mm_struct *mm)
> > >  {
> > >  	struct task_struct *c, *g, *p = current;
> > >
> > > -retry:
> > >  	/*
> > >  	 * If the exiting or execing task is not the owner, it's
> > >  	 * someone else's problem.
> > > @@ -468,16 +484,16 @@ void mm_update_next_owner(struct mm_struct *mm)
> > >  	 * Search in the children
> > >  	 */
> > >  	list_for_each_entry(c, &p->children, sibling) {
> > > -		if (c->mm == mm)
> > > -			goto assign_new_owner;
> > > +		if (c->mm == mm && try_to_set_owner(c, mm))
> > > +			goto ret;
> >
> > You need to unlock tasklist_lock, right? Same for other goto ret.
> 
> No. From the patch
> 
> 	+/* drops tasklist_lock if succeeds */
> 	+static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
> 	+{
> 	+       bool ret = false;
> 	+
> 	+       task_lock(tsk);
> 	+       if (likely(tsk->mm == mm)) {
> 	+               /* tsk can't pass exit_mm/exec_mmap and exit */
> 	+               read_unlock(&tasklist_lock);
> 	                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> try_to_set_owner() drops tasklist right after it verifies that
> tsk->mm == mm under task_lock().

Yes, I am blind and the commend even explains that. I am not a propoment 
of schemes where locks are released in a different function. But the
overall simplification here is worth that.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs

