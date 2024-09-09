Return-Path: <linux-kernel+bounces-321934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FF972175
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B66282E14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AB17A938;
	Mon,  9 Sep 2024 17:58:47 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64320DC4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904727; cv=none; b=Jfj/TapNEYYtm3vPpOwOBEELoVQSorsVjZcLSuNdm5KHKjtUzLDLvcUgsCAc26KRBLNMk0sLSJhhb9rpqyVfPBpyIxxijM63kSHFBpnNZSid3I0MBkXsEzgwwznNJl0OIl/WGcvBmJ2b9eoWbIjV8qVlpKlpDILFxw3i891jXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904727; c=relaxed/simple;
	bh=86gayZiJxUNS2vkLbrqqd+91QnLGyL9A2ymiV67UPjg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=f2OTtCqua2qkhd6yAPytfleLnlYhsx8TPsT1zR18Kl3NIYPFis18cvbynkYSGfi7dPcXpXD3SoqUveH9sHHMVtw7FItpeP9dXSHYsgPthUP0uIS3MiTR0+niyx71ChT0I+tD1z6dHiW+oQ8M8pCHjX8fP8JI01IT4tyR5G2TmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:45256)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sniHb-00EMzf-T9; Mon, 09 Sep 2024 11:34:35 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:59660 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sniHb-0073Cx-17; Mon, 09 Sep 2024 11:34:35 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  apais@microsoft.com,  benhill@microsoft.com,  ssengar@microsoft.com,
  sunilmut@microsoft.com,  vdso@hexbites.dev
References: <20240905212741.143626-1-romank@linux.microsoft.com>
	<20240905212741.143626-2-romank@linux.microsoft.com>
	<20240906112345.GA17874@redhat.com>
	<CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
	<da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
	<CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
	<61713c72-bd86-4694-9c06-49579a33d8f3@linux.microsoft.com>
	<87ed5ser6i.fsf@email.froward.int.ebiederm.org>
	<20240909170529.GB14058@redhat.com>
Date: Mon, 09 Sep 2024 12:34:28 -0500
In-Reply-To: <20240909170529.GB14058@redhat.com> (Oleg Nesterov's message of
	"Mon, 9 Sep 2024 19:05:30 +0200")
Message-ID: <874j6oenob.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sniHb-0073Cx-17;;;mid=<874j6oenob.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+HjguPSsVLPprQ8L41HhgRnhEUpHFk4SI=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 276 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (3.9%), b_tie_ro: 9 (3.4%), parse: 0.72 (0.3%),
	 extract_message_metadata: 2.3 (0.8%), get_uri_detail_list: 0.55
	(0.2%), tests_pri_-2000: 2.8 (1.0%), tests_pri_-1000: 2.1 (0.8%),
	tests_pri_-950: 0.99 (0.4%), tests_pri_-900: 0.84 (0.3%),
	tests_pri_-90: 110 (39.7%), check_bayes: 108 (39.3%), b_tokenize: 4.0
	(1.5%), b_tok_get_all: 6 (2.1%), b_comp_prob: 1.46 (0.5%),
	b_tok_touch_all: 94 (34.3%), b_finish: 0.69 (0.3%), tests_pri_0: 124
	(45.1%), check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 2.8
	(1.0%), poll_dns_idle: 1.02 (0.4%), tests_pri_10: 4.0 (1.5%),
	tests_pri_500: 11 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: vdso@hexbites.dev, sunilmut@microsoft.com, ssengar@microsoft.com, benhill@microsoft.com, apais@microsoft.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, romank@linux.microsoft.com, oleg@redhat.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/09, Eric W. Biederman wrote:
>>
>> I suspect the best way to support breakpoint_if_debugging (in the
>> general case) is to make them nop functions,
>
> or may be make it call a single function which can be used as a
> breakpoint placeholder.

That would be much simpler to implement.

> Either way, at least the program with breakpoint_if_debugging() will
> survive under /usr/bin/strace.

Yes, I can't imagine wanting any of that functionality to trigger
when it is just strace using ptrace on a program.

Eric


