Return-Path: <linux-kernel+bounces-577349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17FA71BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1332169019
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E251F585D;
	Wed, 26 Mar 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bYza4FJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dN+aaHNp"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE81EA7E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006509; cv=none; b=EMdlFLmeUfU+PlS4+dNG+tm4IYD+i8FPhBipjECD8N30cYxr73l2/z/mu7esWoHHL4pIRvYrEBS2bEz2aDvfj3naOWjWsCX+B1SKvYsb407ydhdYNBDQlDv5/fk3whNH7Nf5T0ATDleb43F7vuAE78Du1eM+gqQdXB0jlGLg/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006509; c=relaxed/simple;
	bh=Zr7f/8/DLp7ZcIJKcBxvh5ealTCm0c3f38yxMGSpCI0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EasE8Wl/fzTSqu37dC3Xni8sfHIoJtvbCWCBZwftcB/ILDLBMd1sjjdgXOglvY46V5ite0on3Kf+0oBWayuV66Y/VTC8DuekKNCPmfmyBo1vVQJVzvNqnVPg5SouDkE2N6yo2u/wsBwkDfkpm6CXCzGtu1QxwU688x5w1hms8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bYza4FJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dN+aaHNp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8B032540187;
	Wed, 26 Mar 2025 12:28:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 12:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743006504;
	 x=1743092904; bh=AB6R+XAWI5VcKXrLaJxDqz1rDPlHoJLM/7kKxB4tnP8=; b=
	bYza4FJzECBO72rof60HJoFTp6I2Wa41aoHgQDN7vpU5em9wfPyguszH7AVWS9vF
	/Vfneyfzj7ua1KQSX9nhf8OeXnUSkFZ0uLgfMLmqKUNKicnXBRkMYeAh2hTWJLlp
	3Agt2J9bbAktSxqMfC+36TzilMVziHbv4aC94tfqxiA5CgUbk0QdGZYoFyH1mg/l
	Adj8bH7Ys2WJRN4gVK4D5p/cCjtc5Go+5m72IfzZ/3LpQyyo3xGNGyAl3SuZ5PcC
	2zfPGYos9pHGTVSJszAmQGnip9J34pTDvJbr034jf2TmHbERIPiOQty0B73rtxUT
	X3DZDiiM6aF1r4/tOhQ6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743006504; x=
	1743092904; bh=AB6R+XAWI5VcKXrLaJxDqz1rDPlHoJLM/7kKxB4tnP8=; b=d
	N+aaHNpYWBhtLvfkJ0TSNXcj72rVcMxBx7XdOfmJJDn8iTmbKUqSZa069FNJnDBX
	CWsGFYgyZsKMlV0BVUDrGMHi/y1CM2e7Rluz2OYhXWOQ22C3zFTrwcFxKcNoVg8s
	MXg5IJe5atVVYA9xU7rSq4Z4KyhQowgUfdUyQ5oegbziNdhObaFOKfbTG2rtMg/Q
	+O72zLQPb/F+9AqakGYo3u03lmISdyde28FgSU7AL4JtjExmhbjafPZE0ZpERcme
	ArNzmF6ZGCZp6b7pmrPO8XqJOiCufvysGbrDPPLoBtByeJYH6QgWVAvgjy4q/kxF
	YuTHX4NKPJ0ucujxFLcRw==
X-ME-Sender: <xms:KCvkZ0CSLsjRdDc6oGjEa4dPP79ndWuW1w0KDGQ8jmkl--ufIqce_g>
    <xme:KCvkZ2jhL640cSqcthRRVopEblQXTaC6nl2rVTlxn261cukSshI_i_VJ8DK8xBi1V
    Q6QxZ-Ps1ImCRA7XlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeitdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelveff
    feelkeeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehnuggvshgruhhlnhhivg
    hrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdp
    rhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrsggvlh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KCvkZ3nBJiJaO22TFr8Km6vsAzvzCkIS6cI23vFWgnq8xx66OyME6Q>
    <xmx:KCvkZ6yCwup_CKGYRI0_l0hMd-PyFWIUWC3O3cLNzrE8pewqfPjbuQ>
    <xmx:KCvkZ5TvC5GRPg0x0lGVq9z14udj4ENgdjDzNHUhYAqgjpMRvlteMA>
    <xmx:KCvkZ1aWqjD8faAI51prhAi8HlQ8eSRegsFcyE5BrIOhkjzXlXTevg>
    <xmx:KCvkZ0H63DvBfOxS4_Ij-hhbwPC8zWOLPO_oIxld8-Z7cf70PCN6XaTu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 501632220072; Wed, 26 Mar 2025 12:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1240cda14fee069e
Date: Wed, 26 Mar 2025 17:28:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "kernel test robot" <lkp@intel.com>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <801c7017-ec5a-4439-91e6-36e35020a579@app.fastmail.com>
In-Reply-To: <20250326162355.GA2072652@ax162>
References: <20250321085315.915808-1-arnd@kernel.org>
 <20250325155906.GA1886499@ax162>
 <l77cp7hlskzkauoohviwonal53upcyc74j7x57ycn7sdfkmu4f@fsm4tv2lbtn6>
 <20250326162355.GA2072652@ax162>
Subject: Re: [PATCH] platform: cznic: fix function parameter names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, at 17:23, Nathan Chancellor wrote:
> On Wed, Mar 26, 2025 at 10:38:47AM +0100, Marek Beh=C3=BAn wrote:
>> >=20
>> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>> >=20
>> > You will be taking this I assume?
>>=20
>> Arnd already took it into for-next:
>>   https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log=
/?h=3Dfor-next
>
> Ah odd, it just showed up in -next even though it was applied a few da=
ys
> ago:

Sorry about that, my previous git push had failed because of some other
problem. I also still see two more build issues in the cznic driver,
so I'm sending the pull 6.16 pull request without that one but still
plan to send a follow-up that includes this one and two more changes
once it builds cleanly.

       Arnd

