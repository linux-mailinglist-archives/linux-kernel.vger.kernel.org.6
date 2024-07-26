Return-Path: <linux-kernel+bounces-262944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7993CEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83573283469
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C797176AB2;
	Fri, 26 Jul 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDvVAhnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F76176257
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979667; cv=none; b=T1WXmdosRJ9hSwG92lAZUKYNnz+GX264qCpIn8Ana297fV6iORyoAEt2+5uXlMWPCkR85UCbAy6qeEmt5B8YUqbxETcoraAqs8qr3JCwa7FJGaGYOrCb/FYOBMjkToIkp1tXyUZLQAs0DmKJ/0p0K4sVqCbFIOm4K0TEXwzmorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979667; c=relaxed/simple;
	bh=5596s8iq4z7p649mxvF5CGRs/LiwySptkSSEAsg7RRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2RZjGxZW01QkKlDfLKigDZuxCChpuIPa95o9o+nbU59t0nzPc85YjcRqe6lBRr9TQadrp3ZUrxzwIW6mEyitV8blTxwDYt33wThLk05e4XGP49SghOYiuNkYy89RKGbCPHUdrHZHVlu0a9Z8mU7f3udZHOTZmi10txx26YkTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDvVAhnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0939FC32782;
	Fri, 26 Jul 2024 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721979666;
	bh=5596s8iq4z7p649mxvF5CGRs/LiwySptkSSEAsg7RRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDvVAhnXdyiJksmxo0SiL/UXK+exX+SGTT5kr6lNZcfjcSDqmmkzrot/+W6Gz9k9b
	 LgcwuD0F+92YFYzCfQuXwW0INJmGYKE6Wd8OWLlExRwSBBgGUbUWYzTKKpxLX4Hlt3
	 3Vrk8CJ2Hl8+Vs3g9AvlAFgwyBkkzAWXzWh5CRfEshzbYX36oVSieUkLT7TSOYH1xX
	 yUIVll0yJG0TbG3PltVD06Xy0MOs1O/P5OxKX5WxP16u6oU6KdR4cxROGImduYXYbt
	 oiI8y7pcFICNV5Np7yfwAhctTIazH/6kUFx0mX5kbxZ08okbW5JWKX5x0fEf8qKg5e
	 IXCmWw+K3alAg==
Date: Fri, 26 Jul 2024 09:41:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Kernel hackers <linux-kernel@vger.kernel.org>, 
	Patrick Rohr <prohr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: UML/hostfs - mount failure at tip of tree
Message-ID: <20240726-burggraben-zugluft-351cfa07d2de@brauner>
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
 <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com>
 <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
 <CANP3RGdgnXOXjnAFe6irf2JwrPsStTLvihKkowpY2ggSgNw7KA@mail.gmail.com>
 <CANP3RGd7AQXPYQVrhjbgEN608Jo7hDUh7nc8VQ62gGQqW0iXMg@mail.gmail.com>
 <4a8ae74e-2f90-4da8-9511-325ca6f67aa6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a8ae74e-2f90-4da8-9511-325ca6f67aa6@huawei.com>

On Wed, Jul 24, 2024 at 05:49:16PM GMT, Hongbo Li wrote:
> 
> 
> On 2024/7/24 11:59, Maciej Żenczykowski wrote:
> > On Tue, Jul 23, 2024 at 7:55 PM Maciej Żenczykowski <maze@google.com> wrote:
> > > 
> > > On Tue, Jul 23, 2024 at 7:22 PM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > 
> > > > On Tue, 23 Jul 2024 at 18:35, Hongbo Li <lihongbo22@huawei.com> wrote:
> > > > > 
> > > > > I apologize for causing this issue. I am currently tracking it down.  If
> > > > > reverting this can solve the problem, you can revert it first.
> > > > 
> > > > I don't get the feeling that this is _so_ urgent that it needs to be
> > > > reverted immediately - let's give it at least a few days and see if
> > > > you (or somebody else) figures out the bug.
> > > > 
> > > > Maciej - if you can verify that folio conversion fix suggestion of
> > > > mine (or alternatively report that it doesn't help and I was barking
> > > > up the wrong tree), that would be great.
> > > 
> > > That appears to fix the folio patch indeed (ie. I no longer need to revert it).
> > > 
> > > The tests are still super unhappy, but I've yet to fix our tests very
> > > broken netlink parser for changes that released in 6.10, so that may
> > > be unrelated ;-)
> > 
> > +++ fs/hostfs/hostfs_kern.c:
> >   static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >   {
> >          struct hostfs_fs_info *fsi = sb->s_fs_info;
> > -       const char *host_root = fc->source;
> > +       const char *host_root = "/";
> > 
> This doesn't work in case where the host directory is designated (such as
> mount -t hostfs hostfs -o /home /host).
> 
> I can fix this by the following patch, the root cause of this issue is the
> incorrect parsing of the host directory. The original mount path will use
> `parse_monolithic` to parse the host directory. For the new mount api, it
> use `parse_param` directly. So we should call `fsconfig(fd,
> FSCONFIG_SET_STRING, "hostfs", "xxx", 0)` to mount the hostfs(I think may be
> we should add hostfs as the key for host directory.). This may need
> Christian's reviews.:

I see you sent the patch. I looked at it yesterday but didn't really dig
into it. Let me go do that now. I'll have a pr ready for Linus latest
tomorrow.

