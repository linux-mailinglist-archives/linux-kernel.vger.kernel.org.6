Return-Path: <linux-kernel+bounces-545430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F044A4ED0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357677A5DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1624C08E;
	Tue,  4 Mar 2025 19:16:51 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFC2376EC;
	Tue,  4 Mar 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115810; cv=none; b=NOz7L9vrki8Iadqdan0HrIQUfFlDU2ky/D2NkLqa44UagQiZtUhqYgKCgW/yCDjuIYR9XAo3WTYn5fU3JZqjHwYLw+/Zb/H7o6jjhDkHIWn6Nzs8X6js0epPH6I1hx816o4V3O+NWHhTH99etjh+CDDzVMfL09MxtzOfgShcD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115810; c=relaxed/simple;
	bh=pOWLXes4uWQgjfo1TJ9f6OtmzhBGnF2YDRXOGUxK9lo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=nm7NIl6n3Byh3gW2Vn5mMudj2mJRH1il953fokbd6wmyrspGj5YETbJixFsG7CcFOY7VCny2rmUwMW3D/ch3KvJVis+CE98SctxP+6Pgr8YNRtNB1mWNMtHb6CYSAZ6xHuNo9gVZgouiYWuNCTGX2XYE10Kb7xMhlkGYJvyrINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:41330)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tpXL4-003CrC-Sf; Tue, 04 Mar 2025 11:49:58 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:43810 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tpXL3-009qdL-OE; Tue, 04 Mar 2025 11:49:58 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org,  Dave Hansen <dave.hansen@intel.com>,
  Baoquan He <bhe@redhat.com>,  "Kirill A. Shutemov"
 <kirill@shutemov.name>,  kexec@lists.infradead.org,  Yan Zhao
 <yan.y.zhao@intel.com>,  linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev,  x86@kernel.org,  rick.p.edgecombe@intel.com,
  security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
	<f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
	<fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
	<4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
	<wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
Date: Tue, 04 Mar 2025 12:49:15 -0600
In-Reply-To: <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
	(Kirill A. Shutemov's message of "Tue, 4 Mar 2025 10:41:56 +0200")
Message-ID: <87o6ygskb8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tpXL3-009qdL-OE;;;mid=<87o6ygskb8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+GBcBx8IrnL69HP7CI9T5d+uij0wQ3VeY=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 480 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 10 (2.0%), b_tie_ro: 8 (1.7%), parse: 1.03 (0.2%),
	 extract_message_metadata: 12 (2.6%), get_uri_detail_list: 1.67 (0.3%),
	 tests_pri_-2000: 13 (2.6%), tests_pri_-1000: 2.7 (0.6%),
	tests_pri_-950: 1.26 (0.3%), tests_pri_-900: 1.02 (0.2%),
	tests_pri_-90: 166 (34.5%), check_bayes: 164 (34.1%), b_tokenize: 8
	(1.6%), b_tok_get_all: 8 (1.7%), b_comp_prob: 3.1 (0.7%),
	b_tok_touch_all: 141 (29.4%), b_finish: 0.89 (0.2%), tests_pri_0: 258
	(53.8%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 0.57 (0.1%), tests_pri_10: 2.2 (0.5%),
	tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: security@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, kexec@lists.infradead.org, kirill@shutemov.name, bhe@redhat.com, dave.hansen@intel.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> On Fri, Feb 14, 2025 at 08:20:07AM -0800, Dave Hansen wrote:
>> On 2/14/25 05:46, Kirill A. Shutemov wrote:
>> >> It sounds like you're advocating for the "slow guest boot" option.
>> >> Kirill, can you remind us how fast a guest boots to the shell for
>> >> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
>> >> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
>> > I only have 128GB machine readily available and posted some number on
>> > other thread[1]:
>> > 
>> >   On single vCPU it takes about a minute to accept 90GiB of memory.
>> > 
>> >   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>> >   it doesn't scale past that in my setup.
>> > 
>> > I've mentioned it before in other thread:
>> > 
>> > [1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm
>> 
>> Oh, wow, from that other thread, you've been trying to get this crash
>> fix accepted since November?
>> 
>> From the looks of it, Eric stopped responding to that thread. I _think_
>> you gave a reasonable explanation of why memory acceptance is slow. He
>> then popped back up last month raising security concerns. But I don't
>> see anyone that shares those concerns.
>> 
>> The unaccepted memory stuff is also _already_ touching the page
>> allocator. If it's a dumb idea, then we should be gleefully ripping it
>> out of the page allocator, not rejecting a 2-line kexec patch.
>> 
>> Baoquan has also said this looks good to him.
>> 
>> I'm happy to give Eric another week to respond in case he's on vacation
>> or something, but I'm honestly not seeing a good reason to hold this bug
>> fix up.
>> 
>> Andrew, is this the kind of thing you can stick into mm and hold on to
>> for a bit while we give Eric time to respond?
>
> Andrew, Eric, can we get this patch in?

How goes the work to fix this horrifically slow firmware interface?

Eric


