Return-Path: <linux-kernel+bounces-554422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF121A59782
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9A616B8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9222CBEF;
	Mon, 10 Mar 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQdIyE/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0512248A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616723; cv=none; b=UKkejeojja3kJr3LDyYez5nY0MKp7/XiCeaUCV8dfiiX/fg4/IrBDIzcNS0PcXn0J3cwaWiqSPEpEMPBXpXI42Q4jfSC3g1jcP47nFc+vRoscjSsu031QFd1lO52i5eA4x/KDq1IXPFov4Zmh1yYmeGfMb2tcZXcKh0VfCxC8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616723; c=relaxed/simple;
	bh=nhSM6hGhaPNS8G2A5GuRTSpDenIGSsSvLmZ1Q4r/dkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdRrn53SWedkr65CIKYriqEFAI3lhZv0ZagMIKLe7SgdOjmWZSnFNTVdpaX7/u9MGoG7qk4TGjSCHGDtWNNIl836SiowWu+TVcU3FDFevJRtwOs0MeVNL0R3DEDj13wOsz1VWprBPeP7EVeE8DDUg10IoggxsZmOMCw0vQU1TY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQdIyE/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E1C4CEEB;
	Mon, 10 Mar 2025 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741616722;
	bh=nhSM6hGhaPNS8G2A5GuRTSpDenIGSsSvLmZ1Q4r/dkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQdIyE/3gPbk0Ns1sASELDVoawNCvABYyz4IhxPqqKC3KXTSSHGP2dDh/YjXQz2mw
	 oF5jyN+q3kNfHe4XNNtswk3H77JxVWSSvM6BGFN8gcPT7rYUL8kN/Snh29h3hN3A+p
	 DWouM1saff15lvGWszzzlpe9QPnUmguRFtBpVDWwHFGgqa1vfbTBwkYv8MAcXJwkMJ
	 rexi7QrvH8YTlhAtvUISaUD9m1dQvsGhk++4fODPiXvJVzdlyiDGoEBW74JMLECROA
	 4tF3p1l+VAo2+N79O/uCTwEsARsBdTaAZZlTgz7qsNZ3j02e/51kufIXENOXKBwUiw
	 WJbtFPTFIGeaA==
Date: Mon, 10 Mar 2025 15:25:16 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
Message-ID: <csfegppvkhnl33x37335dsxdxmlzn7jairgsucxl5rdo3d6yzi@2z3nfgtcy7eg>
References: <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
 <e861fc51-f244-4645-af72-56416a422060@linux.dev>
 <qpuf3nepmmkiqt7spcdpyrdnbyzbztr3jgabwou7bjyl746czs@c2iimb3bekr4>
 <806ee13d-cb97-4c27-b645-763c02b51713@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806ee13d-cb97-4c27-b645-763c02b51713@linux.dev>

On Thu, Mar 06, 2025 at 09:33:39PM +0800, Wen Yang wrote:
> 
> 
> On 2025/3/3 17:26, Joel Granados wrote:
> > On Thu, Jan 30, 2025 at 10:32:14PM +0800, Wen Yang wrote:
> > > 
> > > 
> > > On 2025/1/28 01:51, Eric W. Biederman wrote:
> > > > Joel Granados <joel.granados@kernel.org> writes:
> > > > 
> > > > > On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
> > > > > > "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > > > > > 
> > > > > > > Joel Granados <joel.granados@kernel.org> writes:
> > > > > > > 
> > > > > > > > On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
> > ...
...
> > Quick question: Do you have a systemic way of identifying these? Do you
> > have a grep or awk scripts somewhere? I'm actually very interested in
> > finding out what is the impact of this.
> > 
> 
> Thanks, we may use the following simple scripts:
> 
> - the extra {1,2} as pointers to some objects:
> $ grep "\.extra1\|\.extra2" * -R | grep -v "SYSCTL_" | grep -v "\&"
This is actually pretty nice. Thx for that. I executed it a bit
differently: 

$  git grep "\.extra1\|\.extra2" | grep -v "SYSCTL_" | grep -v "&"

I also went and did something way more complicated :). I created an
smatch check [1] and ran it on a allyes config. This gave me all of your
results except the openat2 selftests. This might be something to
consider for when this is finished to add a check so that ppl don't just
add an int or a long to a extra

Best

[1]: https://github.com/Joelgranados/smatch/tree/jag/extra_ptr



> 
> - the extra {1,2} as pointers to elements in the shared constant array:
> $ grep "\.extra1\|\.extra2" * -R | grep "SYSCTL_"
> 
> - the extra {1,2} as pointers to additional constant variables:
> $ grep "\.extra1\|\.extra2" * -R | grep "\&"
> 
> 
> --
> Best wishes,
> Wen
> 
> 
> > 
> > 
> > > 
> > > 
> > > So could we modify it in this way to make it compatible with these two
> > > situations:
> > > 
> > > @@ -137,8 +137,16 @@ struct ctl_table {
> > >          umode_t mode;
> > >          proc_handler *proc_handler;     /* Callback for text formatting */
> > >          struct ctl_table_poll *poll;
> > > -       void *extra1;
> > > -       void *extra2;
> > > +       union {
> > > +               struct {
> > > +                       void *extra1;
> > > +                       void *extra2;
> > > +               };
> > > +               struct {
> > > +                       unsigned long min;
> > > +                       unsigned long max;
> > > +               };
> > > +       };
> > >   } __randomize_layout;
> > > 
> > > 
> > > --
> > > Best wishes,
> > > Wen
> > > 
> > 

-- 

Joel Granados

