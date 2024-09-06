Return-Path: <linux-kernel+bounces-318079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 426CA96E814
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDC01F23EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F66374F1;
	Fri,  6 Sep 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMHlFh8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336C179BC;
	Fri,  6 Sep 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592563; cv=none; b=nqZDx7IXOzNIs9p93hBJqqngtp9l+DuW3z9s0E3pqd1GFZBDwohbJ1HTmIBA1TQDrM6TAetW4TbGzUC/xEhaMBECZaRHVWRjIQmH3VNOxuMcdvnu1xE04QasnZ/4y+wXw8ahOgWPLAFX3/DtjBI4J56pubBcBDzATadEKfFKB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592563; c=relaxed/simple;
	bh=df26tGpjsFDJcHnBE1dEg8GLU7tSzssjXrVEx4wu27Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npvOQi7GzObsHdI5U12pqxXjPiTz0MbxS6taUECrHVsYLhBPrIzpBbNNKQ9g7xSHjcNuHf+bBkdnpRj/Kq52p5GgOKUE1J9hELrXBCJPrOW6+rK1YYeiIwkbweFTyK0BRG3kLJ1eoyc0B+fFbW2ZXy/2vifwisBJDEKhy/3nOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMHlFh8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8604C4CEC3;
	Fri,  6 Sep 2024 03:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592563;
	bh=df26tGpjsFDJcHnBE1dEg8GLU7tSzssjXrVEx4wu27Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMHlFh8V9Tv8mH6SQv5PHl/44gGSa8UAtwuU9soUouV8Xmtpl5YG54XyPclx1qDKn
	 LvPC1T0F+PdmR5fyEqiTJ9XxAt1tZf+zXl9MpfGtzfAfn1j4Sw6wHghMiPZzTiqAZi
	 qBeBTgBe/5vx3xvkArgmO0HNYkd1YdvAmSkOpTZMTdyuL/bg1q1q5qdIon/BMopYAQ
	 1Nvq1yIktyJUgFjy85J/YEIoyIGdj2KmUASXbd1W7MX2TmH3CcQfDIHca3v7aWCDm0
	 rY+aAOfXxcdUb8EI5lyTVU4vYYx7tztGShjlHE1PzlsFr2ETCYdu3l+0XIXLEltqTY
	 Oh9ubVu/Jl8CA==
Date: Thu, 5 Sep 2024 20:16:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <20240906031601.4yodvhurcyi26qb2@treble>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <20240904045201.v3mp4u7pcqj7qrdp@treble>
 <Ztg1wzHB-so2qV2L@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztg1wzHB-so2qV2L@smile.fi.intel.com>

On Wed, Sep 04, 2024 at 01:26:11PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2024 at 09:52:01PM -0700, Josh Poimboeuf wrote:
> > I'm not sure I buy that, we should look closer to understand what the
> > issue is.  Can you share the config and/or toolchain version(s) need to
> > trigger the warning?
> 
> .config is from the original report [1], toolchain is
> Debian clang version 18.1.8 (9)
> 	Target: x86_64-pc-linux-gnu
> 	Thread model: posix
> 	InstalledDir: /usr/bin
> 
> (Just whatever Debian unstable provides)
> 
> [1]: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/

The warning is due to a (minor?) Clang bug, almost like it tried to
optimize but didn't quite finish.

Here's the disassembly:

0000000000000010 <fan_mode_show>:
  10:	e8 00 00 00 00       	call   15 <fan_mode_show+0x5>	11: R_X86_64_PLT32	__fentry__-0x4
  15:	55                   	push   %rbp
  16:	48 89 e5             	mov    %rsp,%rbp
  19:	41 57                	push   %r15
  1b:	41 56                	push   %r14
  1d:	53                   	push   %rbx
  1e:	50                   	push   %rax
  1f:	48 89 d3             	mov    %rdx,%rbx
  22:	49 89 fe             	mov    %rdi,%r14
  25:	e8 00 00 00 00       	call   2a <fan_mode_show+0x1a>	26: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  2a:	4d 8b 76 78          	mov    0x78(%r14),%r14
  2e:	31 f6                	xor    %esi,%esi
  30:	49 8d 7e 08          	lea    0x8(%r14),%rdi
  34:	e8 00 00 00 00       	call   39 <fan_mode_show+0x29>	35: R_X86_64_PLT32	mutex_lock_nested-0x4
  39:	4d 89 f7             	mov    %r14,%r15
  3c:	49 83 c7 08          	add    $0x8,%r15
  40:	74 5b                	je     9d <fan_mode_show+0x8d>
  42:	49 8b 06             	mov    (%r14),%rax
  45:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
  49:	be 2b 00 00 00       	mov    $0x2b,%esi
  4e:	48 8b 78 08          	mov    0x8(%rax),%rdi
  52:	e8 00 00 00 00       	call   57 <fan_mode_show+0x47>	53: R_X86_64_PLT32	.text.read_ec_data-0x4
  57:	4c 89 ff             	mov    %r15,%rdi
  5a:	41 89 c6             	mov    %eax,%r14d
  5d:	e8 00 00 00 00       	call   62 <fan_mode_show+0x52>	5e: R_X86_64_PLT32	mutex_unlock-0x4
  62:	45 85 f6             	test   %r14d,%r14d
  65:	74 07                	je     6e <fan_mode_show+0x5e>
  67:	e8 00 00 00 00       	call   6c <fan_mode_show+0x5c>	68: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  6c:	eb 1b                	jmp    89 <fan_mode_show+0x79>
  6e:	e8 00 00 00 00       	call   73 <fan_mode_show+0x63>	6f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  73:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  77:	48 89 df             	mov    %rbx,%rdi
  7a:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	7d: R_X86_64_32S	.rodata.str1.1+0x508
  81:	e8 00 00 00 00       	call   86 <fan_mode_show+0x76>	82: R_X86_64_PLT32	sysfs_emit-0x4
  86:	41 89 c6             	mov    %eax,%r14d
  89:	49 63 c6             	movslq %r14d,%rax
  8c:	48 83 c4 08          	add    $0x8,%rsp
  90:	5b                   	pop    %rbx
  91:	41 5e                	pop    %r14
  93:	41 5f                	pop    %r15
  95:	5d                   	pop    %rbp
  96:	31 ff                	xor    %edi,%edi
  98:	31 d2                	xor    %edx,%edx
  9a:	31 f6                	xor    %esi,%esi
  9c:	c3                   	ret
  9d:	e8 00 00 00 00       	call   a2 <__param_ctrl_ps2_aux_port+0x2>	9e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  <end of function>


And the interesting bit:

  30:	49 8d 7e 08          	lea    0x8(%r14),%rdi		# rdi = &priv->vpc_mutex
  34:	e8 00 00 00 00       	call   mutex_lock_nested
  39:	4d 89 f7             	mov    %r14,%r15		# r15 = r14 = priv
  3c:	49 83 c7 08          	add    $0x8,%r15		# r15 = &priv->vpc_mutex
  40:	74 5b                	je     9d <fan_mode_show+0x8d>	# if &priv->vpc_mutex == NULL, goto 9d
  ...
  9d:	e8 00 00 00 00       	call   a2 <__param_ctrl_ps2_aux_port+0x2>	9e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  <oof>


If '&priv->vpc_mutex' is NULL, it jumps to 9d, where it calls
__sanitizer_cov_trace_pc().  After that returns, it runs off the rails.

Apparently Clang decided somehow (LTO?) that '&priv->vpc_mutex' can
never be NULL, but it didn't quite finish the optimization.  Maybe some
bad interaction between LTO and KCOV?

Here's the triggering code:

> static ssize_t fan_mode_show(struct device *dev,
> 			     struct device_attribute *attr,
> 			     char *buf)
> {
> 	struct ideapad_private *priv = dev_get_drvdata(dev);
> 	unsigned long result;
> 	int err;
> 
> 	scoped_guard(mutex, &priv->vpc_mutex)
> 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);

Here's the pre-processed code for the scoped_guard() invocation and its
DEFINE_GUARD() dependency, edited for readability:

> typedef struct mutex * class_mutex_t;
> 
> static inline void class_mutex_destructor(struct mutex **p)
> {
> 	struct mutex *_T = *p;
> 	if (_T)
> 		mutex_unlock(_T);
> }
> 
> static inline struct mutex *class_mutex_constructor(struct mutex *_T)
> {
> 	struct mutex *t = ({ mutex_lock_nested(_T, 0); _T; });
> 	return t;
> }
> 
> static inline void *class_mutex_lock_ptr(struct mutex **_T)
> {
> 	return *_T;
> }
> 
> 	for (struct mutex *scope = class_mutex_constructor(&priv->vpc_mutex), *done = ((void *)0);
> 	     class_mutex_lock_ptr(&scope) && !done;
> 	     done = (void *)1) {
> 
> 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
> 	}

The fake "for loop" is needed to be able to initialize the scope
variable inline.  But basically it's doing this:

> 	if (class_mutex_constructor(&priv->vpc_mutex))
> 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);

In this case, mutex is an unconditional guard, so the constructor just
returns the original value of '&priv->vpc_mutex'.  So if the original
'&priv->vpc_mutex' is never NULL, the condition would always be true.

-- 
Josh

