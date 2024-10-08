Return-Path: <linux-kernel+bounces-354373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CF993CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C5F1F21999
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C51E535;
	Tue,  8 Oct 2024 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpzDSh5C"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AC182C5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353886; cv=none; b=Qsv5KbqpyCDshN75xCwdgUf/ctfSW9Cj++CXay5JSZoodsRIZBHGbigU47zTgv5Lv+ZEm/NwYBT/uc7XSVsSjiR5JTnRB+1maje5OCKOJw6Ejwje15c1fXGFtMlzEhTiK74xwwnW3IBqIA5FWxU+B8PbxNj6pCA7z/mxhPa0vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353886; c=relaxed/simple;
	bh=4HxZXNRDeeFXzUmVpqVyQFLwedYD7QQ31GGcL+vxdsE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=B1J75aMGta5yb/LSV0fkfjvJZfhxgOOAf6TpkwsWvLlh9QxwBPn6qN3T6fso55uS6CvZB8Y7NUw72S04Mpu5r8HnkNu88fO6Huu0IJyaTtuQ+vHEBYzB/mI4U99XVrhbnGCEZC5M26T5b+ptUs2oxcwFFSfR21+LbgjE5gevlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpzDSh5C; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728353882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9bOzFVKK3JfHEBqVTHAFgXoxGivGN6wQGN2dmoR/qk=;
	b=rpzDSh5CLpTDTCORn3ec7W8JUNv+F2eDnE1PPWx6AjAZa+7D3K59QiUDnX3xwcyX1gM4n0
	sTGsy9sIhBUtFnPOExA92/7FouDxuseeNkEKgai+VDnyrZH4R9d+vlPRLxbtKGc40p19C+
	PwNmqgqjomS/5bs2TRCxWnnrSA+evqY=
Date: Tue, 08 Oct 2024 02:17:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <5bc5b9b07d997e299b048005826bc6d592265c67@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] ftrace: Get the true parent ip for function tracer
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
In-Reply-To: <20241007171027.629bdafd@gandalf.local.home>
References: <20240910133620.19711-1-jeff.xie@linux.dev>
 <20241005101320.766c1100@rorschach.local.home>
 <20241007171027.629bdafd@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

October 8, 2024 at 5:10 AM, "Steven Rostedt" <rostedt@goodmis.org> wrote:



>=20
>=20On Sat, 5 Oct 2024 10:13:20 -0400
>=20
>=20Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>=20>=20
>=20> The crash happened here:
> >=20
>=20
> This has been bothering me all weekend so I dug more into it.
>=20
>=20The reason it was bothering me is because we use current later on, an=
d it
>=20
>=20has no issue. But then I noticed the real bug!
>=20
>=20I was confused because the crashed instruction pointer was in the
>=20
>=20get_current() code. But that's not where the crash actually happened.
>=20
>=20>=20
>=20> static __always_inline unsigned long
> >=20
>=20>  function_get_true_parent_ip(unsigned long parent_ip, struct ftrace=
_regs *fregs)
> >=20
>=20>  {
> >=20
>=20>  unsigned long true_parent_ip;
> >=20
>=20>  int idx =3D 0;
> >=20
>=20>=20=20
>=20>=20
>=20>  true_parent_ip =3D parent_ip;
> >=20
>=20>  if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler))
> >=20
>=20>  true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip,=
 <<<----- CRASH
> >=20
>=20
> That's not the crash
>=20
>=20>=20
>=20> (unsigned long *)fregs->regs.sp);
> >=20
>=20
> The above is!
>=20
>=20fregs should *NEVER* be used directly. OK, I need to make:
>=20
>=20struct ftrace_regs {
>=20
>=20 void *nothing_here[];
>=20
>=20};
>=20
>=20Now, to stop bugs like this.
>=20
>=20fregs is unique by architecture, and may not even be defined! That is=
, it
>=20
>=20can pass NULL for fregs. And only x86 has fregs->regs available. Othe=
r
>=20
>=20archs do not.

Thanks, I just saw this comment from include/linux/ftrace.h

 * NOTE: user *must not* access regs directly, only do it via APIs, becau=
se
 * the member can be changed according to the architecture.
 */
struct ftrace_regs {
        struct pt_regs          regs;
};


>=20
>=20You must use the fregs helper functions, thus the above can be:
>=20
>=20static __always_inline unsigned long
>=20
>=20function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_re=
gs *fregs)
>=20
>=20{
>=20
>=20 unsigned long true_parent_ip;
>=20
>=20 int idx =3D 0;
>=20
>=20 true_parent_ip =3D parent_ip;
>=20
>=20 if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler) && =
fregs)
>=20
>=20 true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip,
>=20
>=20 (unsigned long *)ftrace_regs_get_stack_pointer(fregs));
>=20
>=20 return true_parent_ip;
>=20
>=20}
>=20
>=20So you can make a v5 with this update. And I'll go and make the empty
>=20
>=20ftrace_regs structure.

Thanks, I will update the patch.

>=20
>=20Thanks!
>=20
>=20-- Steve
>=20
>=20>=20
>=20> return true_parent_ip;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  It appears that on some archs (x86 32 bit) the function tracer can=
 be
> >=20
>=20>  called when "current" is not set up yet, and can crash when access=
ing it.
> >=20
>=20>=20=20
>=20>=20
>=20>  So perhaps we need to add:
> >=20
>=20>=20=20
>=20>=20
>=20>  #ifdef CONFIG_ARCH_WANTS_NO_INSTR
> >=20
>=20>  static __always_inline unsigned long
> >=20
>=20>  function_get_true_parent_ip(unsigned long parent_ip, struct ftrace=
_regs *fregs)
> >=20
>=20>  {
> >=20
>=20>  unsigned long true_parent_ip;
> >=20
>=20>  int idx =3D 0;
> >=20
>=20>=20=20
>=20>=20
>=20>  true_parent_ip =3D parent_ip;
> >=20
>=20>  if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler))
> >=20
>=20>  true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip,=
 <<<----- CRASH
> >=20
>=20>  (unsigned long *)fregs->regs.sp);
> >=20
>=20>  return true_parent_ip;
> >=20
>=20>  }
> >=20
>=20>  #else
> >=20
>=20>  # define function_get_true_parent_ip(parent_ip, fregs) parent_ip
> >=20
>=20>  #endif
> >=20
>=20>=20=20
>=20>=20
>=20>  That is, if the arch has noinstr implemented, it should always be =
safe
> >=20
>=20>  to access current, but if not, then there's no guarantee.
> >=20
>=20>=20=20
>=20>=20
>=20>  ?
> >
>

