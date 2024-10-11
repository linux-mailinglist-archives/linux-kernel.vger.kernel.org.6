Return-Path: <linux-kernel+bounces-360748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0163999EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26C31C22F76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0F20ADEC;
	Fri, 11 Oct 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="izyCYcJ+"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8220A5D5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635144; cv=none; b=WQ/WOm6m3imBqDII2GMydydBY1ISzirBDBQIyVBpGmCq4qLzdLVYClXCzrwgY2/7C01bEmlA6Ryo24+pde5KOMDjSVzbfKCkYXs4A2vjCUukwhF3r/gp/gozhagurI8dZCw0vaUOMDv6QDWcORluPD5umsDt/nPIKosOxCLTDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635144; c=relaxed/simple;
	bh=eZpxRhcvBCU6p0+N1+8vY0azh+KLC9VPIqox+XDFgUA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=p+Tp9BpbI3uqs5zMmnglAiIV45CbdfIMo5KM6gpWaiabz383P1EX0LuEO1NPUFR4IFdkFk5xx2mB70vfEVBQQwHTEVicvigSrolSdr2puO3McrRaA9NDBgMU+kaUpozHRl2aRcqKttnzyc7hntshylbQeKwjGXuG7Vp9wtaeiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=izyCYcJ+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241011082540epoutp03f2dae67e947ff16a7be7785d6fd01c6c~9WIBdqRs_2534425344epoutp03a
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241011082540epoutp03f2dae67e947ff16a7be7785d6fd01c6c~9WIBdqRs_2534425344epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728635140;
	bh=rgNlLWpWErhQrTitpDBorlmBwFplTcRJ8l+yel300j0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=izyCYcJ+Rpjof8XomF98m5Zb868VxipY/JiWCGoi1Z/wSKDHAYn0eCPs2Jm3F49z7
	 sVq7pMEkTvePk739zHwnd8zohwstYkdXJ/3GDURlzbGuDwYBKSUALT8J12N7zX+AQf
	 Rp76wb/3J1vkvjaSjAIEjBZQIzLvXIUyO5HiWnXo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20241011082539epcas1p4383732f2ea2e44d1fc68d94944f4f8e8~9WIBGn2Av1538615386epcas1p48;
	Fri, 11 Oct 2024 08:25:39 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.249]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XQ07R3x00z4x9QB; Fri, 11 Oct
	2024 08:25:39 +0000 (GMT)
X-AuditID: b6c32a4c-02dff70000004ba3-97-6708e1039d4f
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.DC.19363.301E8076; Fri, 11 Oct 2024 17:25:39 +0900 (KST)
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
In-Reply-To: <b8c56752-3451-4f15-b7f6-c18234ae4565@suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241011082539epcms1p6039313672abedf63d5368a3eae87bad5@epcms1p6>
Date: Fri, 11 Oct 2024 17:25:39 +0900
X-CMS-MailID: 20241011082539epcms1p6039313672abedf63d5368a3eae87bad5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmgS7zQ450g1uXpS3mrF/DZvHykKZF
	9+aZjBZN+2ayW1zeNYfN4t6a/6wWy76+Z7c4/PUNk8Xsxj5GB06PnbPusnss2FTqsWlVJ5vH
	pk+T2D1OzPjN4tG3ZRWjx5kFR9g9Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgVqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8fHXBOaCjX1MFbcuTGFqYFxk2sXIySEhYCJx
	4NAbli5GLg4hgT2MEqcXTgNyODh4BQQl/u4QBqkRFnCUuNf6hQ3EFhJQkjj74wo7RFxXoql7
	NQuIzSagLfF+wSRWkDkiAo8YJbZceMkO4jALLGaUaFt5lAliG6/EjPanLBC2tMT25VsZQWxO
	AWuJy7u7oOKiEjdXv2WHsd8fm88IYYtItN47ywxhC0o8+LmbEWbOn+PP2SDsYollnQ+gdtVI
	rDi3CipuLtHwdiWYzSvgK/Hsy0Sw+SwCqhIT77VDzXGR2LnlBlgNs4C8xPa3c5hBAcEsoCmx
	fpc+RJhP4t3XHlaYVxo2/mbHxt4x7wnUCWoSLc++QtXLSPz994wVZKSEgIfE65XJExgVZyFC
	ehaSvbMQ9i5gZF7FKJVaUJybnppsWGCom5daDo/h5PzcTYzg1Krls4Px+/q/eocYmTgYDzFK
	cDArifDqLmRNF+JNSaysSi3Kjy8qzUktPsRoCvT1RGYp0eR8YHLPK4k3NLE0MDEzMrEwtjQ2
	UxLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qByZ29n+9D/PzSab7a2ec+saz4wu8yzWem70Od
	rleik+5PXZGgLsBsaqyuorFcNsXprRf//5Ct/fx/FxilznoVcFJ8areYf+4ek499idzy/9tc
	LTadqrgk8dNn5VShdUkL3fedtvqhy6XyLS7o5LNpPjvNly59fiZEoPXtP77Jr16WHH7Z3sxa
	NllYdZENG3dR83O+J5lMm0q0xetMOWfFPeHTztHK+rGj1r/8D2eR25VN6xJjArY3zvhjtuE8
	M99dzaJPs1JtKx4Gzr68b/qCs9dstWNN7uxfJchiZyNx+uThVsHC2O/Wbbssv6Zfu2SQ8Sz2
	0onX7GIaE3bOn+e5d2rmOQ1zZqt4XtdqNU8rJZbijERDLeai4kQAh0pIYzYEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179
References: <b8c56752-3451-4f15-b7f6-c18234ae4565@suse.cz>
	<20241009093124.3647359-1-jaewon31.kim@samsung.com>
	<CGME20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179@epcms1p6>

>> The reclaim_folio_list uses a dummy reclaim_stat and is not being                                                                                                                       
>> used. To know the memory stat, add a new trace event. This is useful how                                                                                                                
>> how many pages are not reclaimed or why.                                                                                                                                                
>>                                                                                                                                                                                         
>> This is an example.                                                                                                                                                                     
>> mm_vmscan_reclaim_pages: nr_scanned=17 nr_reclaimed=17 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0      
>>                                                                                                                                                                                         
>> Currenlty reclaim_folio_list is only called by reclaim_pages, and                                                                                                                       
>> reclaim_pages is used by damon and madvise. In the latest Android,                                                                                                                      
>> reclaim_pages is also used by shmem to reclaim all pages in a                                                                                                                           
>> address_space.                                                                                                                                                                          
>>                                                                                                                                                                                         
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>                                                                                                                                    
>> ---                                                                                                                                                                                     
>>  include/trace/events/vmscan.h | 41 +++++++++++++++++++++++++++++++++++                                                                                                                 
>>  mm/vmscan.c                   | 40 +++++++++++++++++++++++++++++-----                                                                                                                  
>>  2 files changed, 76 insertions(+), 5 deletions(-)                                                                                                                                      
>>                                                                                                                                                                                         
>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h                                                                                                              
>> index 1a488c30afa5..509110a12fa5 100644                                                                                                                                                 
>> --- a/include/trace/events/vmscan.h                                                                                                                                                     
>> +++ b/include/trace/events/vmscan.h                                                                                                                                                     
>> @@ -346,6 +346,47 @@ TRACE_EVENT(mm_vmscan_write_folio,                                                                                                                                 
>>  		show_reclaim_flags(__entry->reclaim_flags))                                                                                                                                         
>>  );                                                                                                                                                                                     
>>                                                                                                                                                                                         
>> +TRACE_EVENT(mm_vmscan_reclaim_pages,                                                                                                                                                   
>> +                                                                                                                                                                                       
>> +	TP_PROTO(unsigned long nr_scanned, unsigned long nr_reclaimed,                                                                                                                        
>> +		struct reclaim_stat *stat),                                                                                                                                                         
>> +                                                                                                                                                                                       
>> +	TP_ARGS(nr_scanned, nr_reclaimed, stat),                                                                                                                                              
>> +                                                                                                                                                                                       
>> +	TP_STRUCT__entry(                                                                                                                                                                     
>> +		__field(unsigned long, nr_scanned)                                                                                                                                                  
>> +		__field(unsigned long, nr_reclaimed)                                                                                                                                                
>> +		__field(unsigned long, nr_dirty)                                                                                                                                                    
>> +		__field(unsigned long, nr_writeback)                                                                                                                                                
>> +		__field(unsigned long, nr_congested)                                                                                                                                                
>> +		__field(unsigned long, nr_immediate)                                                                                                                                                
>> +		__field(unsigned int, nr_activate0)                                                                                                                                                 
>> +		__field(unsigned int, nr_activate1)                                                                                                                                                 
>> +		__field(unsigned long, nr_ref_keep)                                                                                                                                                 
>> +		__field(unsigned long, nr_unmap_fail)                                                                                                                                               
>> +	),                                                                                                                                                                                    
>> +                                                                                                                                                                                       
>> +	TP_fast_assign(                                                                                                                                                                       
>> +		__entry->nr_scanned = nr_scanned;                                                                                                                                                   
>> +		__entry->nr_reclaimed = nr_reclaimed;                                                                                                                                               
>> +		__entry->nr_dirty = stat->nr_dirty;                                                                                                                                                 
>> +		__entry->nr_writeback = stat->nr_writeback;                                                                                                                                         
>> +		__entry->nr_congested = stat->nr_congested;                                                                                                                                         
>> +		__entry->nr_immediate = stat->nr_immediate;                                                                                                                                         
>> +		__entry->nr_activate0 = stat->nr_activate[0];                                                                                                                                       
>> +		__entry->nr_activate1 = stat->nr_activate[1];                                                                                                                                       
>> +		__entry->nr_ref_keep = stat->nr_ref_keep;                                                                                                                                           
>> +		__entry->nr_unmap_fail = stat->nr_unmap_fail;                                                                                                                                       
>> +	),                                                                                                                                                                                    
>> +                                                                                                                                                                                       
>> +	TP_printk("nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld",
>> +		__entry->nr_scanned, __entry->nr_reclaimed,                                                                                                                                         
>> +		__entry->nr_dirty, __entry->nr_writeback,                                                                                                                                           
>> +		__entry->nr_congested, __entry->nr_immediate,                                                                                                                                       
>> +		__entry->nr_activate0, __entry->nr_activate1,                                                                                                                                       
>> +		__entry->nr_ref_keep, __entry->nr_unmap_fail)                                                                                                                                       
>> +);                                                                                                                                                                                     
>> +                                                                                                                                                                                       
>>  TRACE_EVENT(mm_vmscan_lru_shrink_inactive,                                                                                                                                             
>>                                                                                                                                                                                         
>>  	TP_PROTO(int nid,                                                                                                                                                                     
>> diff --git a/mm/vmscan.c b/mm/vmscan.c                                                                                                                                                  
>> index 749cdc110c74..4776c42dfd2a 100644                                                                                                                                                 
>> --- a/mm/vmscan.c                                                                                                                                                                       
>> +++ b/mm/vmscan.c                                                                                                                                                                       
>> @@ -2126,9 +2126,9 @@ static void shrink_active_list(unsigned long nr_to_scan,                                                                                                          
>>  }                                                                                                                                                                                      
>>                                                                                                                                                                                         
>>  static unsigned int reclaim_folio_list(struct list_head *folio_list,                                                                                                                   
>> -				      struct pglist_data *pgdat)                                                                                                                                                
>> +				      struct pglist_data *pgdat,                                                                                                                                                
>> +				      struct reclaim_stat *stat)                                                                                                                                                
>>  {                                                                                                                                                                                      
>> -	struct reclaim_stat dummy_stat;                                                                                                                                                       
>>  	unsigned int nr_reclaimed;                                                                                                                                                            
>>  	struct folio *folio;                                                                                                                                                                  
>>  	struct scan_control sc = {                                                                                                                                                            
>> @@ -2139,7 +2139,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,                                                                                              
>>  		.no_demotion = 1,                                                                                                                                                                   
>>  	};                                                                                                                                                                                    
>>                                                                                                                                                                                         
>> -	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);                                                                                                          
>> +	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, stat, true);                                                                                                                 
>>  	while (!list_empty(folio_list)) {                                                                                                                                                     
>>  		folio = lru_to_folio(folio_list);                                                                                                                                                   
>>  		list_del(&folio->lru);                                                                                                                                                              
>> @@ -2149,16 +2149,40 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,                                                                                            
>>  	return nr_reclaimed;                                                                                                                                                                  
>>  }                                                                                                                                                                                      
>>                                                                                                                                                                                         
>> +static void reclaim_stat_add(struct reclaim_stat *stat_from,                                                                                                                           
>> +			     struct reclaim_stat *stat_to)                                                                                                                                                
>> +{                                                                                                                                                                                      
>> +	int type;                                                                                                                                                                             
>> +                                                                                                                                                                                       
>> +	if (!trace_mm_vmscan_reclaim_pages_enabled())                                                                                                                                         
>> +		return;                                                                                                                                                                             
>> +                                                                                                                                                                                       
>> +	stat_to->nr_dirty += stat_from->nr_dirty;                                                                                                                                             
>> +	stat_to->nr_unqueued_dirty += stat_from->nr_unqueued_dirty;                                                                                                                           
>> +	stat_to->nr_congested += stat_from->nr_congested;                                                                                                                                     
>> +	stat_to->nr_writeback += stat_from->nr_writeback;                                                                                                                                     
>> +	stat_to->nr_immediate += stat_from->nr_immediate;                                                                                                                                     
>> +	stat_to->nr_pageout += stat_from->nr_pageout;                                                                                                                                         
>> +	for (type = 0; type < ANON_AND_FILE; type++)                                                                                                                                          
>> +		stat_to->nr_activate[type] += stat_from->nr_activate[type];                                                                                                                         
>> +	stat_to->nr_ref_keep += stat_from->nr_ref_keep;                                                                                                                                       
>> +	stat_to->nr_unmap_fail += stat_from->nr_unmap_fail;                                                                                                                                   
>> +	stat_to->nr_lazyfree_fail += stat_from->nr_lazyfree_fail;                                                                                                                             
>> +}                                                                                                                                                                                      
>                                                                                                                                                                                          
>Could we avoid this by using a single stat that just accumulates over                                                                                                                     
>multiple calls to reclaim_folio_list()?                                                                                                                                                   
>                                                                                                                                                                                          
>That means shrink_folio_list() would not do the initial memset(0) and it                                                                                                                  
>would be caller responsibility.      

Hi

Thank you for your coment. Yes if it is allowed, I can do that way. When
I checked, the following functions should do the memset().

reclaim_clean_pages_from_list
shrink_inactive_list
reclaim_folio_list
evict_folios      

Actually I was planning to move trace_mm_vmscan_reclaim_pages into
reclaim_folio_list so that we don't have to sum up and we may be able
to print node number, too. As we will see log for each node, if we'd
like to know the sum, that would be the post parser's job.

Option 1. No change on memset, but print on each node.
mm_vmscan_reclaim_pages: nid=0 nr_scanned=112 nr_reclaimed=112 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
mm_vmscan_reclaim_pages: nid=1 ...
mm_vmscan_reclaim_pages: nid=2 ...

Option 2. Change on memset, but we don't care the stat from each node.
mm_vmscan_reclaim_pages: nr_scanned=35 nr_reclaimed=35 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0

Would you give me you preference between the two options?
                                                        
Thank you
Jaewon Kim
                                                                                                                                                     
>                                                                                                                                                                                          
>AFAICS shrink_folio_list() only cares about these fields:                                                                                                                                 
>                                                                                                                                                                                          
>pgactivate = stat->nr_activate[0] + stat->nr_activate[1];                                                                                                                                 
>                                                                                                                                                                                          
>in order to do                                                                                                                                                                            
>                                                                                                                                                                                          
>count_vm_events(PGACTIVATE, pgactivate);                                                                                                                                                  
>                                                                                                                                                                                          
>Which could be adjusted to deal with accumulating stat - i.e. take an                                                                                                                     
>initial sum of the fields in stat and subtract from the final sum to get                                                                                                                  
>the delta.                                                                                                                                                                                
>                                                                                                                                                                                         
>>  unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                                              
>>  {                                                                                                                                                                                      
>>  	int nid;                                                                                                                                                                              
>> +	unsigned int nr_scanned = 0;                                                                                                                                                          
>>  	unsigned int nr_reclaimed = 0;                                                                                                                                                        
>>  	LIST_HEAD(node_folio_list);                                                                                                                                                           
>>  	unsigned int noreclaim_flag;                                                                                                                                                          
>> +	struct reclaim_stat stat_total, stat_one;                                                                                                                                             
>>                                                                                                                                                                                         
>>  	if (list_empty(folio_list))                                                                                                                                                           
>>  		return nr_reclaimed;                                                                                                                                                                
>>                                                                                                                                                                                         
>> +	memset(&stat_total, 0, sizeof(stat_total));                                                                                                                                           
>>  	noreclaim_flag = memalloc_noreclaim_save();                                                                                                                                           
>>                                                                                                                                                                                         
>>  	nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                            
>> @@ -2168,14 +2192,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                       
>>  		if (nid == folio_nid(folio)) {                                                                                                                                                      
>>  			folio_clear_active(folio);                                                                                                                                                        
>>  			list_move(&folio->lru, &node_folio_list);                                                                                                                                         
>> +			nr_scanned += folio_nr_pages(folio);                                                                                                                                              
>>  			continue;                                                                                                                                                                         
>>  		}                                                                                                                                                                                   
>>                                                                                                                                                                                         
>> -		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                               
>> +		nr_reclaimed += reclaim_folio_list(&node_folio_list,                                                                                                                                
>> +						   NODE_DATA(nid), &stat_one);                                                                                                                                              
>> +		reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                           
>>  		nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                          
>>  	} while (!list_empty(folio_list));                                                                                                                                                    
>>                                                                                                                                                                                         
>> -	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                                 
>> +	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),                                                                                                                  
>> +					   &stat_one);                                                                                                                                                                
>> +	reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                             
>> +	trace_mm_vmscan_reclaim_pages(nr_scanned, nr_reclaimed, &stat_total);                                                                                                                 
>>                                                                                                                                                                                         
>>  	memalloc_noreclaim_restore(noreclaim_flag);                                                                                                                                           
>>                                                                                                                                                                                         

