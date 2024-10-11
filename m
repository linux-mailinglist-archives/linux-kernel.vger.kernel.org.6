Return-Path: <linux-kernel+bounces-361053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497C99A2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A919F1F23FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFD216A0C;
	Fri, 11 Oct 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p0e7B9Kz"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403B216432
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646767; cv=none; b=dWdTtXPZuKI8J+d3E73QiLn0/9UGePyJn7GNseUwtSPaPwj+992xx/n4YmEZ37lFYMxG5eUMVfrcaJMioV1JGP3iPTu8Ur/bGPyRx1ig3bkc8B94wWYA3TYJBOhlQJEnp8YJVgAzzRbP2zGyQmMPFz2O8wdSe1Kzyc4qXJfDDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646767; c=relaxed/simple;
	bh=yG2Mj5Xs5ceShLsfLa3JMi6f/N3QqWxXElUoKoA8SQM=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=CcuZP+iuB1iNAMAt/a6/b2jO8jjg1K8mHGbgFJGuc+y9VPfc39i7fNORC9TCY2kt2lEEU5MThQehZ2UoRaC67zenPTEt0bxjQPze1c5k5ZN1eiJ8cl2xtbytbjUiQos+EFCQSOncGpsVPWxfAbsdwc3VlAoSVg+sW6mSXtNy6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p0e7B9Kz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241011113922epoutp03ac218896d17d5d003e384cffd2a37f94~9YxJZ2L4q0855008550epoutp032
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241011113922epoutp03ac218896d17d5d003e384cffd2a37f94~9YxJZ2L4q0855008550epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728646762;
	bh=LMhp7fEYhMoyCnDFFS/hYKn62hYUZJQDUlw5oNGD2AY=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=p0e7B9KzITtsuE7Plj+HTv8Rbe6c2TDY0zi+nlrJTtrf7/O/WQZ/wXYU3g+lIrjRE
	 +6znPsevEEiju09K+m05z3hfbPLpTnqRQBwOhqjAzpYRwpZ05qbiN6s7OSsBByMdos
	 H3aDlFEDbNIvp5AU4j2HQau7R0+hx7I7yUB9GyeM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20241011113921epcas1p4e84f5b58b44f3da89ec56e248439addd~9YxIdS6N02699626996epcas1p4M;
	Fri, 11 Oct 2024 11:39:21 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.222]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XQ4Qx0S1Fz4x9Q1; Fri, 11 Oct
	2024 11:39:21 +0000 (GMT)
X-AuditID: b6c32a4c-02dff70000004ba3-e9-67090e686769
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.36.19363.86E09076; Fri, 11 Oct 2024 20:39:20 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] vmscan: add a vmscan event for reclaim_pages
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: Vlastimil Babka <vbabka@suse.cz>, "sj@kernel.org" <sj@kernel.org>,
	"minchan@kernel.org" <minchan@kernel.org>, "kaleshsingh@google.com"
	<kaleshsingh@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <dd7e07ba-acaf-4f93-93e0-ec2d98a4da55@suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241011113919epcms1p4d6ae59bece34d4a930a5db31a2f00173@epcms1p4>
Date: Fri, 11 Oct 2024 20:39:19 +0900
X-CMS-MailID: 20241011113919epcms1p4d6ae59bece34d4a930a5db31a2f00173
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmgW4GH2e6wYkl1hZz1q9hs3h5SNOi
	e/NMRoumfTPZLS7vmsNmcW/Nf1aLZV/fs1sc/vqGyWJ2Yx+jA6fHzll32T0WbCr12LSqk81j
	06dJ7B4nZvxm8ejbsorR48yCI+wenzfJBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZ
	GOoaWlqYKynkJeam2iq5+AToumXmAF2npFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1I
	ySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjO6DyzgbngXnzF9V2bGBsYF0p3MXJySAiYSJya
	OImti5GLQ0hgD6PEuVmbGbsYOTh4BQQl/u4QBqkRFnCUuNf6hQ3EFhJQkjj74wo7RFxXoql7
	NQuIzSagLfF+wSRWkDkiAo8YJbZceMkO4jALLGaUaFt5lAliG6/EjPanLBC2tMT25VsZQWxO
	AWuJL28b2CDiohI3V79lh7HfH5vPCGGLSLTeO8sMYQtKPPi5mxFmzp/jz6F6iyWWdT6A2lUj
	seLcKqi4uUTD25VgNq+Ar8TE9+/A5rAIqEocb/sPVeMi8fZRN9htzALyEtvfzmEGBQSzgKbE
	+l36EGE+iXdfe1hhXmnY+JsdG3vHvCdQJ6hJtDz7ClUvI/H33zNWkJESAh4Sr1cmT2BUnIUI
	6VlI9s5C2LuAkXkVo1RqQXFuemqyYYGhbl5qOTyCk/NzNzGCE6uWzw7G7+v/6h1iZOJgPMQo
	wcGsJMKru5A1XYg3JbGyKrUoP76oNCe1+BCjKdDXE5mlRJPzgak9ryTe0MTSwMTMyMTC2NLY
	TEmc98yVslQhgfTEktTs1NSC1CKYPiYOTqkGJrlFO/y6fvDcv53QcVzgpvfORp/5PA8Fgrks
	s2rTk7vOzCvoX3CNn2F9Rr7VudZayZfCN3uCbfpuRSTX7onweOeUsE6juu8Z944uvcXmLlEx
	2/iifgrslw7Nr62sO7H09+ldGmvUNhtV7I28MINrkvZtXiXJe7PPF5rNr1HfMONd1wrT2P7X
	rg5LXITTuH9uW795xsNLP05tmDJ9Ov8mGU5Dp7eKwb35JdNPZLkKLX984dOFzozZbCe8Z+/P
	9ptZmZnmrz6RtfhDpuCueW86lktc/cstVFn3QvgY5/elVu9Dol8ek1jfp7Hu6OELjedfZ3q8
	fiWrHN+eFTvjSWHwY6aLmU/319y80/tZfP7bFUosxRmJhlrMRcWJAAGq+uE1BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179
References: <dd7e07ba-acaf-4f93-93e0-ec2d98a4da55@suse.cz>
	<b8c56752-3451-4f15-b7f6-c18234ae4565@suse.cz>
	<20241009093124.3647359-1-jaewon31.kim@samsung.com>
	<20241011082539epcms1p6039313672abedf63d5368a3eae87bad5@epcms1p6>
	<CGME20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179@epcms1p4>

>On 10/11/24 10:25 AM, Jaewon Kim wrote:
>> Hi
>> 
>> Thank you for your coment. Yes if it is allowed, I can do that way. When
>> I checked, the following functions should do the memset().
>> 
>> reclaim_clean_pages_from_list
>> shrink_inactive_list
>> reclaim_folio_list
>> evict_folios      
>> 
>> Actually I was planning to move trace_mm_vmscan_reclaim_pages into
>> reclaim_folio_list so that we don't have to sum up and we may be able
>> to print node number, too. As we will see log for each node, if we'd
>> like to know the sum, that would be the post parser's job.
>> 
>> Option 1. No change on memset, but print on each node.
>> mm_vmscan_reclaim_pages: nid=0 nr_scanned=112 nr_reclaimed=112 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
>> mm_vmscan_reclaim_pages: nid=1 ...
>> mm_vmscan_reclaim_pages: nid=2 ...
>
>I see. Note it processes a list that might be from multiple nodes and
>will group consecutive pages from the same node, but if pages come from
>random nodes, the nodes will repeat and there might be many trace
>events, each for few pages only.
>
>Guess it depends on the workload if it has its pages from the same node.
>Maybe you can try and see how noisy it is in practice?
>

Hi

Actually my Android test device has only one node, so I cannot test several
nodes cases. But it shows quite many of mm_vmscan_reclaim_pages log when I do
the Android shmem based call to reclaim_pages. I have to do the post parsing
or make a fancy ftrace hist command.

I think madvise and damon, which are the other caller to reclaim_pages, are not
interested in showing trace log for each node.

I'm just worried changing policy, memset(0) is the caller responsibility,
could be error-prone if we forget someday. So if possible, let me take the
option 1.

To show a clean code, let me submit the v2 patch.
Thank you.

>> Option 2. Change on memset, but we don't care the stat from each node.
>> mm_vmscan_reclaim_pages: nr_scanned=35 nr_reclaimed=35 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
>> 
>> Would you give me you preference between the two options?
>>                                                         
>> Thank you
>> Jaewon Kim
>>                                                                                                                                                      
>>>                                                                                                                                                                                          
>>> AFAICS shrink_folio_list() only cares about these fields:                                                                                                                                 
>>>                                                                                                                                                                                          
>>> pgactivate = stat->nr_activate[0] + stat->nr_activate[1];                                                                                                                                 
>>>                                                                                                                                                                                          
>>> in order to do                                                                                                                                                                            
>>>                                                                                                                                                                                          
>>> count_vm_events(PGACTIVATE, pgactivate);                                                                                                                                                  
>>>                                                                                                                                                                                          
>>> Which could be adjusted to deal with accumulating stat - i.e. take an                                                                                                                     
>>> initial sum of the fields in stat and subtract from the final sum to get                                                                                                                  
>>> the delta.                                                                                                                                                                                
>>>                                                                                                                                                                                         
>>>>  unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                                              
>>>>  {                                                                                                                                                                                      
>>>>  	int nid;                                                                                                                                                                              
>>>> +	unsigned int nr_scanned = 0;                                                                                                                                                          
>>>>  	unsigned int nr_reclaimed = 0;                                                                                                                                                        
>>>>  	LIST_HEAD(node_folio_list);                                                                                                                                                           
>>>>  	unsigned int noreclaim_flag;                                                                                                                                                          
>>>> +	struct reclaim_stat stat_total, stat_one;                                                                                                                                             
>>>>                                                                                                                                                                                         
>>>>  	if (list_empty(folio_list))                                                                                                                                                           
>>>>  		return nr_reclaimed;                                                                                                                                                                
>>>>                                                                                                                                                                                         
>>>> +	memset(&stat_total, 0, sizeof(stat_total));                                                                                                                                           
>>>>  	noreclaim_flag = memalloc_noreclaim_save();                                                                                                                                           
>>>>                                                                                                                                                                                         
>>>>  	nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                            
>>>> @@ -2168,14 +2192,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                       
>>>>  		if (nid == folio_nid(folio)) {                                                                                                                                                      
>>>>  			folio_clear_active(folio);                                                                                                                                                        
>>>>  			list_move(&folio->lru, &node_folio_list);                                                                                                                                         
>>>> +			nr_scanned += folio_nr_pages(folio);                                                                                                                                              
>>>>  			continue;                                                                                                                                                                         
>>>>  		}                                                                                                                                                                                   
>>>>                                                                                                                                                                                         
>>>> -		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                               
>>>> +		nr_reclaimed += reclaim_folio_list(&node_folio_list,                                                                                                                                
>>>> +						   NODE_DATA(nid), &stat_one);                                                                                                                                              
>>>> +		reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                           
>>>>  		nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                          
>>>>  	} while (!list_empty(folio_list));                                                                                                                                                    
>>>>                                                                                                                                                                                         
>>>> -	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                                 
>>>> +	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),                                                                                                                  
>>>> +					   &stat_one);                                                                                                                                                                
>>>> +	reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                             
>>>> +	trace_mm_vmscan_reclaim_pages(nr_scanned, nr_reclaimed, &stat_total);                                                                                                                 
>>>>                                                                                                                                                                                         
>>>>  	memalloc_noreclaim_restore(noreclaim_flag);                                                                                                                                           
>>>> 

