Return-Path: <linux-kernel+bounces-539248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C84A4A26E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE03189A6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36C1F8734;
	Fri, 28 Feb 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKV/qnz7"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7611F09A2;
	Fri, 28 Feb 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769664; cv=none; b=MQ3y8l1XmzABk4rd4ZVErk8q676MrUmMTWe4pd0nFMTkkJFf9EjQoV9pfA++VBRTkx/GZfQRRjsv/n4BgwaYjYDCFq1ytwYgKkllAwymID4F+/EmW1lSj/xAKUFxMpgV2CkVN2vAVtMPqQ6/QHIjXguZOo72ldge5vqB4s1fQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769664; c=relaxed/simple;
	bh=hVbiyGdm34bNJB6A7kGKonj4Ivno8/JQrCzadq3aZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8iIiEzt+wLsWOtNcK1xkv/bjjjS8LnOqV0H3pWcKwYzg8V5YjezgM3yKcw4k8K4kwn5X7FzkQtTdNcxdakaUjnDiL3iirXj301o6KaTlO3NQtf/77um04lVfqzboahOya+C1H9Lfh0GVHs4mOzEdiQMFxVxAN5oUOXOKaEnOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKV/qnz7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08fc20194so399984085a.2;
        Fri, 28 Feb 2025 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769662; x=1741374462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY9kOcXfNT6q7b3WEbz6lqfnbgfJN5i/8lGI0MjDv4o=;
        b=lKV/qnz7fU5vABPfnN30WQbJIXYT/3lL20J8Wcqo2NyMdqTKx+59mxRq6vJuPkYO1/
         jLeOkqhIXsaCFei6nbZcK7UlLVFBNeBuGOYPV+4PTm6kWWD/KKh0/l598H6+9CmR6EoH
         V8g70oD421CmRqBtJ8QzygISUMxfvv6qGwUidHHGuFDF61UcEql0Ph2CGig0S2nudJt4
         szm5h0Emh0RX6OExi/yjP+Km6K0b1vg0H4fcqjhtJ5Hgzxqzcrf2l+XG53KoT1fcg50J
         4wHBPbxcdD5MN1bX5ZJgP78nZIHO9jh6lweCJRWoPWTmA67yI6W+/6jZp8MKMu+d8E6L
         UOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769662; x=1741374462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY9kOcXfNT6q7b3WEbz6lqfnbgfJN5i/8lGI0MjDv4o=;
        b=qjfECKmH+Yp2+Y4ua2NLRbxV5HPsylEfMV9080CxwvuqQTzPTcvQhXioveXl6qZCdA
         9Vw/oREuAm0A0aT22glp+Upjm5GQn49Ubx5U3TXvuTN4KEYgxCnFmssTfKuyuE6eaqKN
         phbGIMMzGjbGcjXnzYiQqMrkiO5CkF72QLOjWna662iac+tQOecLagz750DdNvHqKSqO
         n7eWxfT6EAFwPKYyHGodi+E8qnXtmP/pU6VoyDTHDdOa336uXK4x061eX761uCxJyR+1
         eGgBVN4+ft+4y3qshB7u9/HWVPDQ5cqWqRCf8OGhKin0NTkD5WBEFIXjtguQLl74NNX3
         3UjA==
X-Forwarded-Encrypted: i=1; AJvYcCVpiOi7TY72pr57MiZB2CrNzOmecu3ysSaZp5jAET84yNZUqlXVISIryllymu4uW2N80mYQfAY2AHgOW0g=@vger.kernel.org, AJvYcCWZaY64xFSFxzl4WFqU8GueIpRtkiq7z3VV5hqR7nqIiAzxiKBz1UZ+bbfOjzhLTDzeSYmmvWzq3/siqRFFd30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyob9QvvQGrrvVh0gWsRjhSgPrZ/vuUNqcyV5AbMhZ05OW42mqx
	Mu+3yhhrJdmk3k/MekbbuIUCjJvksgMGjgyS/WufbbJl2ZH3g16/
X-Gm-Gg: ASbGncsAECmMg7is4rNG9+cNHA3zc/fQT1oDJh5t7gWy5GJmoLwPEOnsPkutNDCY3RF
	6dCPm5pEGFjOU2oWKSUhgWbyxtj48QIHQHtNU4R4Bj73UUnrHwDRmQMmC3kWk4hRyInu97xdsZz
	Wh3v2W/e85c9BVLapQJBSLTnpbVaCSzgVl8EE3Qsbo5wRGTt/rOGqnssu4qGjbfrUbWoHRTn0p0
	/w0941ZgutWQ1QIieBk1oaeYyW3BUAKDJZYrvHVytKBH7CiQy81IbggHYEiC+S7Q55aeNpHlY/Z
	pFHjGOy0H+kfrILYiCQOnR9E0vWdEiKKpWcqAof0SdL3o+J9bIs4GcD5ewWVta95DN2C2E4UZpK
	UFw7A5aDSopyobFSf
X-Google-Smtp-Source: AGHT+IFVDwuYIogi3xtXjTpOHUYApbAzUL6K/529/t6kBnlod8tmXCGEIMlAw2mkLCjpXBc8dVT90A==
X-Received: by 2002:a05:620a:4053:b0:7c0:ab10:113d with SMTP id af79cd13be357-7c39c62f88bmr684335185a.38.1740769661581;
        Fri, 28 Feb 2025 11:07:41 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9e31csm278876285a.75.2025.02.28.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:07:41 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8316E120006D;
	Fri, 28 Feb 2025 14:07:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 14:07:40 -0500
X-ME-Sender: <xms:fAnCZ6lPAfDgHvpEzKc3EkRWyIMFBGnVPhodYggzo1N2P6TyWjEDTA>
    <xme:fAnCZx3d4qPOpYvyVQT9LAwYHf1P3LaCpwOOgbdIY3CTHdRRYpEOh3ZhRdKjVxpPB
    G04pPhoBuISh-P4Ug>
X-ME-Received: <xmr:fAnCZ4qLXI7mUmc-R3yzNWzEiRytnIGRp_P03NSFanctAvZ7ZvjvZAYHP-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeholhhivhgvrhdrmhgrnhhgohhlugesphhmrdhmvgdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmgh
    hrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:fAnCZ-nR4FapnZkGzT4Fe0UfAwMpTUOevIhQ5DswGYmrQ6_1knVGUw>
    <xmx:fAnCZ416YMcIKTq_6SVq_9vm75HtG-UkoMZ4iNhi0h_6J70SZ1c9AA>
    <xmx:fAnCZ1t4EVMa2pX4u9cjLP5zk1EWojTeIgI7EdB_E4nvQSXjsvdjAw>
    <xmx:fAnCZ0WSE2F21gKGEOlUr4vCj_7tpnyz23OmWtZplapaGgfSBsnDSg>
    <xmx:fAnCZz0SDKEo84aBmu45xRSODjrtyVLUIUqPTIIxm2SOhWL7ks0mUkU6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 14:07:39 -0500 (EST)
Date: Fri, 28 Feb 2025 11:06:39 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8IJPzlvioBZaV5M@boqun-archlinux>
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>
 <sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid>
 <Z8IBiBi6CSRxfxiE@boqun-archlinux>
 <87senxlwpo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87senxlwpo.fsf@kernel.org>

On Fri, Feb 28, 2025 at 08:01:55PM +0100, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > On Fri, Feb 28, 2025 at 06:22:58PM +0000, Oliver Mangold wrote:
> >> On 250228 1009, Boqun Feng wrote:
> >> >
> 
> Something strange is going on with this thread. Some replies are not
> attached to the patch in my email client. Lore also has some trouble.
> 
> What is going on?
> 

Probably because some of Oliver's replys don't have the "in-reply-to"
field in the email header. Maybe it's a known issue of protonmail?

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

