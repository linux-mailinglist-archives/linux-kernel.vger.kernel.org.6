Return-Path: <linux-kernel+bounces-526593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C0A400B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022D3B9A37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D95253349;
	Fri, 21 Feb 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Vv0UeUH0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344E25333B;
	Fri, 21 Feb 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169432; cv=none; b=WQoMxjOy9uU28qZVQprtimM7g+iCfQ1Yyt/7fxK6jC75wVF4OUFtyjhr/c638Jcsl/rGTrWYks7QQ7iwsNBjKNsSBfch/dYCcAT82nDPpv8dS7CfJQy69BM9yotYL+llBXzugeOhJ95V33fTZ5W2KDJ/nhDK2c5jnIxiq9D/QF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169432; c=relaxed/simple;
	bh=xhiCsw0kDTJ/hH6Hp77inQFq7FRAVS53RalAZ+j7z/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beyJOebTv2RFv/Ah0A3iSh1qIDIesNJaOfREcINJFJfG/esZyNc+697L0WpApU93AOWih7J9VPBW2/7pO19bwgUzl4c+Hj1YVgpkj9VKgKmQAEtBywVX5fG4mzfdHGo2lPYjpaR70Gqv6JPheW+4l85XxvSvaHLTs06pO1EUHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Vv0UeUH0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CE3B2EC;
	Fri, 21 Feb 2025 21:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1740169344;
	bh=xhiCsw0kDTJ/hH6Hp77inQFq7FRAVS53RalAZ+j7z/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vv0UeUH0dhyuaiC0WjJ+MMxAly1j6Bl7SdEgY7p7B0F/XOyvYrE3uWKM/A44WcD9o
	 IGUeB4LleiVTYEHUvTSBz7R2Att4bJ1osHpmuT3NCsw+QjTeiZHr65jyO8eqCxidpu
	 gURX1GkOBhRQvMz/b8LKMx4Z+MV/Q3mXSjLiacbU=
Date: Fri, 21 Feb 2025 22:23:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jan Engelhardt <ej@inai.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250221202332.GA6576@pendragon.ideasonboard.com>
References: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>

On Fri, Feb 21, 2025 at 09:06:14PM +0100, Jan Engelhardt wrote:
> On Friday 2025-02-21 19:34, David Laight wrote:
> >> 
> >> Returning aggregates in C++ is often implemented with a secret extra
> >> pointer argument passed to the function. The C backend does not
> >> perform that kind of transformation automatically. I surmise ABI reasons.
> >
> > Have you really looked at the generated code?
> > For anything non-trivial if gets truly horrid.
> >
> > To pass a class by value the compiler has to call the C++ copy-operator to
> > generate a deep copy prior to the call, and then call the destructor after
> > the function returns - compare against passing a pointer to an existing
> > item (and not letting it be written to).
> 
> And that is why people generally don't pass aggregates by value,
> irrespective of the programming language.

It's actually sometimes more efficient to pass aggregates by value.
Considering std::string for instance,

std::string global;

void setSomething(std::string s)
{
	global = std::move(s);
}

void foo(int x)
{
	std::string s = std::to_string(x);

	setSomething(std::move(s));
}

Passing by value is the most efficient option. The backing storage for
the string is allocated once in foo(). If you instead did

std::string global;

void setSomething(const std::string &s)
{
	global = s;
}

void foo(int x)
{
	std::string s = std::to_string(x);

	setSomething(s);
}

then the data would have to be copied when assigned global.

The std::string object itself needs to be copied in the first case of
course, but that doesn't require heap allocation. The best solution
depends on the type of aggregates you need to pass. It's one of the
reasons string handling is messy in C++, due to the need to interoperate
with zero-terminated strings, the optimal API convention depends on the
expected usage pattern in both callers and callees. std::string_view is
no silver bullet :-(

> > Returning a class member is probably worse and leads to nasty bugs.
> > In general the called code will have to do a deep copy from the item
> > being returned
> 
> People have thought of that already and you can just
> `return std::move(a.b);`.

Doesn't that prevent NRVO (named return value optimization) in C++ ?
Starting in C++17, compilers are required to perform copy ellision.

> > Then you get code like:
> >	const char *foo = data.func().c_str();
> > very easily written looks fine, but foo points to garbage.
> 
> Because foo is non-owning, and the only owner has gone out of scope.
> You have to be wary of that.
> 
> > You can return a reference - that doesn't go out of scope.
> 
> That depends on the refererred item.
> 	string &f() { string z; return z; }
> is going to explode (despite returning a reference).
> 
> > (Apart from the fact that c++ makes it hard to ensure all the non-class
> > members are initialised.)
> 
> 	struct stat x{};
> 	struct stat x = {};
> 
> all of x's members (which are scalar and thus non-class) are
> initialized. The second line even works in C.

-- 
Regards,

Laurent Pinchart

