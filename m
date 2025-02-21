Return-Path: <linux-kernel+bounces-526325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978CAA3FD49
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAAC3AC94F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73424E4C9;
	Fri, 21 Feb 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IN8MTOpI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6nWFbFd"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6B24E4C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158155; cv=none; b=ksWtGjdBa7IpWDDyL/zY4mq1VNkZnE/AoIdvvw4wlAWhq3NZyOYZ3wN6EY24XiIPwlyEtzRHyJq+29vzgYyhKfli1IQ6hX7o+UfwsnW2JEkYUVTEpGs9CAQZ4/HZN2qQSRA14f2+eQC0Y3isvELbpRKhREwJvMkOUopuGdUBNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158155; c=relaxed/simple;
	bh=UDLNX75wrtdrPkLs6St7iKlfLBG75AiNWZFV0P2/UJA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pGdGvEhP30JYq8Rl3JlE8Ym94SI86wclFLufg8s89uugK+4dZIjw5WjOxzbCon6XuaosPfCL9W2RQzivAcBfyHo2aKH9wk7aPm39UtLtr4IJtdsc/vKT3XjbLsOXqhApP2q2YO1yIM0Tp5CkE4DtEGRxVG5x7QzXbdCOhOfNDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IN8MTOpI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6nWFbFd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 49B351380860;
	Fri, 21 Feb 2025 12:15:51 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 21 Feb 2025 12:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740158151;
	 x=1740244551; bh=SE+FVhO5aeUeVsW1ecaij/35kJ3a9wvdqlNv0gH8jdg=; b=
	IN8MTOpIZSIBkgCLQjCILzaNiwQGMVanaiMWMKdkNatX2MHXBToYaD8JAiyil3dv
	7LW111AVk/5o2FJWBYBGXywMwnI+GykpbbZdLYIN9XDv7gYYzfq1LxsZFsdrNsWL
	tUIJgLt7h8TkLjs45l01dJwssC9phwJ9NynQmwiPGmvZd7XMRCy41YfSceP/3NoV
	5XW0VYMKIT1s0EcPaADc+tEhIIuZpE80V7rEQD5zUCn7hLJhvUf5igelzuxBAjZD
	2Jl8D3mcelkKAewr44amLTwvUAD2w8KzHTHGD3kCIhLo/wsjXmHZyGTAJXiqian2
	SUq2ozKgxETfvz6iZm6Onw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740158151; x=
	1740244551; bh=SE+FVhO5aeUeVsW1ecaij/35kJ3a9wvdqlNv0gH8jdg=; b=G
	6nWFbFd3Wq20ZK+vXFJqsNzVuD75Ne7E+k12XXrbrpTjlref6YhkYu/wCMRCdNXx
	tDfYxnUNsb/CWzafignkGEOafWvGUbgE2ILIFsdSnYwQLyVsJMSIjhRpePzvccu1
	WLJwZNB0nwQ/MdsTh/QlkPOBrz4vx9lrmu7+sKw/iN8R7cJgNFajRLmiNJ6Tk935
	DFQ/FryS7w3OaeJM3m4u2IMvVVNVz6T3byD/ImlAHCU1CoKEJ+Tbu897EeZ11/LC
	jn2+qgcAbSqshlfz5j+nj0ZhzxWbXhklceCMeAtL80in/G+1a2pBzLWaTSf3oCVZ
	x1s7YDinR2F0P3JDRB51Q==
X-ME-Sender: <xms:xrS4ZzuntPfnNijk3Batm_DHPveG1p1rbpvYfph-2DvlUPqpDErZ3g>
    <xme:xrS4Z0dShGKJAlWVIzVqM_CJfylc_UWAGjmLKVFSGDXms2TM-4tdadSJm6tp35yBn
    eqiWqtXcpgaZPY5JFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehr
    rggrghdrjhgruggrvhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhhihidrsh
    hhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhr
    vghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepughrih
    dquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xrS4Z2wqFze9aQST4hrYSX1P_oimghUc9IBieIhjddBFoHTDXEuglw>
    <xmx:xrS4ZyOEbU33jKRHS5bzkaNaTM72jSuMjRSOj3ib3DGQDRN-DNdkgw>
    <xmx:xrS4Zz954ML2OFJR5n59eu-wrnZGZnKFNJB6sUR75QEuL0duW4yO4g>
    <xmx:xrS4ZyXWfI-Jg77PDSx3tDIYUomCMeneRE_GM90yqFoF2WR_-eiNVA>
    <xmx:x7S4ZzxRVuAjhKro-XF1gUgUdZbvlHNEKjYnEyA77dlUukNw3QJSOM8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE60D2220072; Fri, 21 Feb 2025 12:15:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 18:15:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Raag Jadav" <raag.jadav@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com>
In-Reply-To: <Z7iuulG0Ltoltl8F@smile.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
 <Z7iuulG0Ltoltl8F@smile.fi.intel.com>
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2025, at 17:50, Andy Shevchenko wrote:
> On Fri, Feb 21, 2025 at 11:15:47AM +0100, Arnd Bergmann wrote:
>> As you already found, removing an old indirect #include that is
>> no longer needed usually leads to some files breaking. The more
>> impactful your change is in terms of build speed, the more
>> things break! I think in this case, removing linux/err.h and
>> linux/bug.h made very little difference because they are very
>> small files in terms of what else they include.
>
> While this is all true, removing unneeded inclusions rarely can lead to the
> "extra work with a little gain". When there is a replacement to the low
> level ones, it's also an improvement in my opinion and won't be harmful in
> the future. But I agree, that the stuff is way too tangled already and requires
> an enormous work to untangle it, even if doing it structurally.

The problem I see with prematurely applying small improvements like this
one is that they always cause build regressions, at least if the change
is any good. If we can find some more impactful changes like this one,
we can group them together in a branch and test them a lot better before
they even reach linux-next.

I mainly want to avoid people getting angry at Raag for repeatedly
breaking their subsystems by pushing small patches one at a time.

> Do you have your scripts for the showed statistics being published somewhere?

I had a good set of scripts on an older machine and might still
have some backups of that somewhere, but just hacked up something
ad-hoc today beased on what I remembered from that time. Here
are the snippets that you might find useful.

A patch to Kbuild to create a list of each included header for each
object file built in a given configuration (similar to the .filename.o.d
files, but in a format I found more convenient):

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -307,7 +307,8 @@ cmd_ld_single = $(if $(objtool-enabled)$(is-single-obj-m), ; $(LD) $(ld_flags) -
 endif
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< ; \
+                   $(CC) $(c_flags) -E -o - $< | grep ^\#.*include | cut -f 2 -d\" | sort -u > $@.includes \
                $(cmd_ld_single) \
                $(cmd_objtool)
 
shell oneliner to find the header files that are most commonly included
from those files:

$ find -name \*includes | xargs cat | sort | uniq -c | sed -e 's:\./\|\././::g' | sort -rn | head -n 1000 > mostincluded

oneliner to preprocess each of those headers 

$ cat mostincluded | grep include/linux | while read a i ; do gcc -E $i -o ${i%.h}.i ${GCCARGS} ; done

oneliner to sort by product of includes and lines:

$ cat mostincluded | grep include/linux/ | while read a b ; do if [ -e ${b%.h}.i ] ; then echo $a `wc -l ${b%.h}.i` ; fi ; done | sort -n -k2 | while read a b c ; do echo $[$a * $b] $a $b $c ; done | sort -nr > fulllist

In the old days, I had cleaner versions of these in an automated script,
and produced a .dot file to visualize the dependencies with graphviz.
I did get to the point of more than doubling compile speed, so there was
a clear incentive to continue. In fact, the further I got along the way,
the better the savings. In the end I gave up when I could not
get to a useful subset to upstream first that wouldn't already break
hundreds of drivers.

The best idea I have to avoid that is to pick one header to clean up
from my list and do all the prerequisites but not actually break anything
at first.

      Arnd

