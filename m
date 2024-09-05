Return-Path: <linux-kernel+bounces-317468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999796DEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2552B284219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4D19D8A3;
	Thu,  5 Sep 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="QVmIezZx"
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C913BAE3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551222; cv=none; b=Fux8KpHcycJhfSz9LuldzKY/hw4KN/Xd20hgEZWt3wCPCV6ChmHK5oKUo7rvSzudDAB/jbc+YCerUY+rVUVCgHQzvbC4n7Tg0MXo8zhHnm70NWXtkU2yIfEEe9EXSN0AG98CRHwYXaAmHdMVU66Xgwyr1I09WiBYy+vW2xIwEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551222; c=relaxed/simple;
	bh=f/L1vJBQcrayJOQ2JHYkGIgWrGSNwvUW1OTxLAbYxxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lSgPLL/0VkGX5Y7WRsqyLHMv8WpKPyUMMtyHujgegyLI80SylB4O8+x4Czj4Yt9N2gjTpgcsnLl9Q4WUzlfLH3b4iD3g7ofbAf96LGnaGggpkjyGWyzB54Pf6xK9bQMLgxtGjZL0dxz0jXQ2GK8gx0xNhNc09Hy63Y99oXcOxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=QVmIezZx; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1725550978;
	bh=f/L1vJBQcrayJOQ2JHYkGIgWrGSNwvUW1OTxLAbYxxQ=;
	h=From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=QVmIezZxp0brODB4Wk0QOGqKQGqpzt6R7vodKy0vVUSLc0/0ghI+XRtWBA0HMW/DG
	 KNS2vvptNC3mEjMxQ1no4Qgq1qzwW7u2JzTxAmuOsg3AjSu3ELUFwvW8WLfkWdtEne
	 O9eo6vd0sO+tg3RPAv1Q4458FRBtXmFDryis4wap9zwU9/MxM69zQK/cxML8ddLFVJ
	 2aLFXdrS7+SAIPXHNbpOOHOo1zdQZz6NvpdYwXSOw7Lmwv4oCZUXOo0K+06qwz4W+j
	 XviQYwBCuLG/6X55FhQnfhuorWRYuXb/RXKiCQ/SjbldXP5I6YmU9/b2jUHJesXenR
	 V/HtC3fCCi/qg==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.159])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 16AFD3103E6C;
	Thu,  5 Sep 2024 15:42:56 +0000 (UTC)
Date: Thu, 5 Sep 2024 22:42:54 +0700
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	GNU/Weeb Mailing List <gwml@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	Ravel Kevin Ethan <silverwolf@gnuweeb.org>,
	Michael William Jonathan <moe@gnuweeb.org>
Subject: Public Inbox Output Broken Due to Double HTML Encoding
Message-ID: <ZtnRfnHrxVeEwTwx@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1


Hi,

We have noticed a recent issue with the lore public inbox output where
it appears to be affected by double HTML encoding. This problem
surfaced after 1 September 2024, as that was the last time we observed
the correct output.

The issue is particularly visible in email headers, where characters
such as <, >, and quotes are incorrectly encoded twice. This results in
unreadable and improperly rendered email headers. It also breaks
several links in the HTML output.

For instance, in this thread:

    https://lore.kernel.org/qemu-devel/20240905141211.1253307-1-kraxel@redhat.com/

Here's the current, broken output:
```
From: Gerd Hoffmann &lt;kraxel@redhat.com&gt;
To: qemu-devel@nongnu.org
Cc: &#34;Paolo Bonzini&#34; &lt;pbonzini@redhat.com&gt;,
	&#34;Yanan Wang&#34; &lt;wangyanan55@huawei.com&gt;,
	&#34;Zhao Liu&#34; &lt;zhao1.liu@intel.com&gt;,
	&#34;Eduardo Habkost&#34; &lt;eduardo@habkost.net&gt;,
	&#34;Richard Henderson&#34; &lt;richard.henderson@linaro.org&gt;,
	&#34;Marcel Apfelbaum&#34; &lt;marcel.apfelbaum@gmail.com&gt;,
	&#34;Philippe Mathieu-Daud&#233;&#34; &lt;philmd@linaro.org&gt;,
	&#34;Michael S. Tsirkin&#34; &lt;mst@redhat.com&gt;,
```

And here's the expected output:
```
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Paolo Bonzini" <pbonzini@redhat.com>,
	"Yanan Wang" <wangyanan55@huawei.com>,
	"Zhao Liu" <zhao1.liu@intel.com>,
	"Eduardo Habkost" <eduardo@habkost.net>,
	"Richard Henderson" <richard.henderson@linaro.org>,
	"Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
	"Philippe Mathieu-Daudé" <philmd@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Gerd Hoffmann" <kraxel@redhat.com>
```

It seems like the encoding process is being applied redundantly, causing
special characters like &lt; (for <) and &gt; (for >) to render
improperly. This double encoding affects both usability and
readability, especially when dealing with email threads that rely
heavily on clear headers for communication between contributors.

For reference, I have also attached a screenshot of the output, which
can be found here:

    https://gist.github.com/ammarfaizi2/bbb1480822ece70cf2d261e876bd7ba2

It would be great if this could be resolved as soon as possible to
restore the proper display of inbox outputs.

Thank you for your attention to this matter!

-- 
Ammar Faizi


