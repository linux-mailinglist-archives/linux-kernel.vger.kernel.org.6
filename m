Return-Path: <linux-kernel+bounces-541270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B389A4BAC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067737A589C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E71F0E4F;
	Mon,  3 Mar 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCxNLUwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D901F03F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994001; cv=none; b=ruaoVv2SVyPVxaLNkcOfOVFrYx4+DiRIzBktE9GlWH8bEoMxbnRj2fln3lfx6cFa02dlNCv4ISMJQpY3zTYKjwH9rqpCXfzU+vzqjx7755a028co4/fLrnXDhunT8g2nIVu9hVv+oahHRSXKsENU/uveJZ/QPE6ze3Ga8cLc4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994001; c=relaxed/simple;
	bh=5J5FoRpHWCaP9q6MB87Ggn2CuOK29sTqAyL3zf45UkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfgLzxuVzS39xGgQZsyeuXZYSdw/kR22D53USm5sBS0YjVYWo6FQF43w1aYt/qJVq8NoSEpWojjeq8xVitE0LMrJ8NwgqnWKaYMRkEFnD62lb4tucUsdB7G3ic4MG937wN2M9gSq3VaOBsJHBA74TTrQWw8kX1wmQE9DDP1gJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCxNLUwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6544C4CEE5;
	Mon,  3 Mar 2025 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740994001;
	bh=5J5FoRpHWCaP9q6MB87Ggn2CuOK29sTqAyL3zf45UkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCxNLUwxVt8P4IDJTYSg2Amb+IkJ2+/q9RbytntGwFAI4Nhj+p+0EmYH1HtUe3eO4
	 YORsQcIVLAOdGD9tiCskTc3+mv8I4pI7ffoc/D6lVwQpOZ/jOJUjHWWECpucEJQ7dv
	 yWKOuF2hLLFaQq2WU0wD+MWhw+mWYAIdLQ8xZBXeLpCyshUnEpVPQFnDF3vuWsJNp5
	 IZd/oojmObpCW0eBBaPZjdATBJNPvekbyHRuVBBa0WrVm2J1xJuKrXBmpp6DcscLj/
	 RQz12uopU9z0HO+o3gJWYOGbF1iRBAsQV3xvcUz+Znyiq9bkRUqUqFSh//fIoxxJ9l
	 fI/tcyU5QB+UQ==
Date: Mon, 3 Mar 2025 10:26:36 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
Message-ID: <qpuf3nepmmkiqt7spcdpyrdnbyzbztr3jgabwou7bjyl746czs@c2iimb3bekr4>
References: <20250105152853.211037-1-wen.yang@linux.dev>
 <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
 <e861fc51-f244-4645-af72-56416a422060@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e861fc51-f244-4645-af72-56416a422060@linux.dev>

On Thu, Jan 30, 2025 at 10:32:14PM +0800, Wen Yang wrote:
> 
> 
> On 2025/1/28 01:51, Eric W. Biederman wrote:
> > Joel Granados <joel.granados@kernel.org> writes:
> > 
> > > On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
> > > > "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > > > 
> > > > > Joel Granados <joel.granados@kernel.org> writes:
> > > > > 
> > > > > > On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
...
> > > struct ctl_table {
> > > 	const char *procname;		/* Text ID for /proc/sys */
> > > 	void *data;
> > > 	int maxlen;
> > > 	umode_t mode;
> > > 	proc_handler *proc_handler;	/* Callback for text formatting */
> > > 	struct ctl_table_poll *poll;
> > >        unsigned long min;
> > >        unsigned long max;
> > > } __randomize_layout;
> > 
> > That is just replace extra1 and extra2 with min and max members.  The
> > members don't have any reason to be pointers.  Without being pointers
> > the min/max functions can just use long values to cap either ints or
> > longs, and there is no room for error.  The integer promotion rules
> > will ensure that even negative values can be stored in unsigned long
> > min and max values successfully.  Plus it is all bog standard C
> > so there is nothing special to learn.
> > 
> > There are a bunch of fiddly little details to transition from where we
> > are today.  The most straightforward way I can see of making the
> > transition is to add the min and max members.  Come up with replacements
> > for proc_doulongvec_minmax and proc_dointvec_minmax that read the new
> > min and max members.  Update all of the users.  Update the few users
> > that use extra1 or extra2 for something besides min and max.  Then
> > remove extra1 and extra2.  At the end it is simpler and requires the
> > same or a little less space.
> > 
> > That was and remains my suggestion.
> > 
> 
> Thanks for your valuable suggestions. We will continue to move forward along
> it and need your more guidance.
> 
> But there are also a few codes that do take the extra{1, 2} as pointers, for
> example:
> 
> int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>                           proc_handler *handler)
> {
> ...
>         for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
>                 t->neigh_vars[i].data += (long) p;
>                 t->neigh_vars[i].extra1 = dev;
>                 t->neigh_vars[i].extra2 = p;
>         }
> ...
> }
> 
> static void neigh_proc_update(const struct ctl_table *ctl, int write)
> {
>         struct net_device *dev = ctl->extra1;
>         struct neigh_parms *p = ctl->extra2;
>         struct net *net = neigh_parms_net(p);
>         int index = (int *) ctl->data - p->data;
> ...
> }
Quick question: Do you have a systemic way of identifying these? Do you
have a grep or awk scripts somewhere? I'm actually very interested in
finding out what is the impact of this.

Thx

Best


> 
> 
> So could we modify it in this way to make it compatible with these two
> situations:
> 
> @@ -137,8 +137,16 @@ struct ctl_table {
>         umode_t mode;
>         proc_handler *proc_handler;     /* Callback for text formatting */
>         struct ctl_table_poll *poll;
> -       void *extra1;
> -       void *extra2;
> +       union {
> +               struct {
> +                       void *extra1;
> +                       void *extra2;
> +               };
> +               struct {
> +                       unsigned long min;
> +                       unsigned long max;
> +               };
> +       };
>  } __randomize_layout;
> 
> 
> --
> Best wishes,
> Wen
> 

-- 

Joel Granados

