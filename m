Return-Path: <linux-kernel+bounces-430623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45E9E33A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C5164B90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28548188006;
	Wed,  4 Dec 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W3FHgm4a"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7A183CC2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294783; cv=none; b=GhjM2oGH8U1wwrHAvqnboZno2ssMoS9vy0lU72HbK6LVqNiYtcxIXKuhRMfe1yDHV0sQHZLJlJD7MuYwDT1+raiEUh9uk043zbDZ6rtba62TicKHQqgujFn4iTPXDxQbzezzxHTx91OjIJlHaSS+FFoIJbDHK58GONCY8wXvT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294783; c=relaxed/simple;
	bh=zwYDImrZs15aV8zEx0o5xD0LCFWwlvzYATVfdWzhG5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHXM7NW9cHdMwqR4eFOZjAnwebNp4YK7tEFKxaNN0BYsBh7NBizjZkns6JYhOq6W5+Blfw2nrL7FFY3ORwAScIiE1giZgu0O5NWW9RDdv6EWKISLHif3e/QDr/LA4xmH/QpowAGEdhX370e26gCqXsort18wbMBqNsHyrvVamY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W3FHgm4a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434941aac88so5508925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 22:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733294780; x=1733899580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKLCwyYRyRhRV+7HHjXl1CRS1Do8/otxgiGgDTGtFOg=;
        b=W3FHgm4a5xHR79ORhqQDX6bCoOVytNbYmjW82AOwZJhXQVfCUfKqsJgtlx1q79HXMH
         PhWIYAW+pVgoo5bf5jN/OfhHGQLIC9sYYyvy6JXeM94o3nEDflJG47EeY10Njremgu/4
         1+JUTnXbmMAl3Ge7Q5/crizqS9wAW5+ZtK/5acGW+42sK2Iq1qMYsIwmZNSjNQgPNmjw
         U3CLme3005Y6OEXqknJpYVEUn6qcWh/HErNepZtobYe5mJPhJGpwg0n1CwRQwO1VtZs5
         zY794rV1GYK2rtJv8FfD9lFPY2dSSE+dtWeseUrpE7O+dosiWpEihPUbitSOG3B+WbKX
         73mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733294780; x=1733899580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKLCwyYRyRhRV+7HHjXl1CRS1Do8/otxgiGgDTGtFOg=;
        b=fNuFk+Dwmk5rWlQPFq0wvOVA0YXbzszc1dBDggGCz7eyU3NokLA+gDfrtoPlPq2NzP
         x2rb2SgP+A0fydlentJVuohHo36O6IfX/99CvEnuQtHZUOBTDCES1mQ6NylRLxaSl6Y9
         0WjnpHHt50ftYObZqwNf9pPU4UIwRqsgRNGVfGuGdRFPLv+bg/13ESRochKyr41GFsO/
         SdG662Hv85njUA6Y4o/qWCFzqCDeu1IASgH6O9mUqPYVqlUROO0BaVFc/eUSbMusTLVl
         wkhow7Z0A8OkVPbiJT34HMt3OYituInWoiCIQs2T0RDzMIhRzvm9gaADpHDItK0k4rBN
         ZTtA==
X-Gm-Message-State: AOJu0Yzc3EzeuZYJpz8iFmYC3SHhkisd/q1hQuF7Sn8E5h70ZXOQPJZF
	LsI/Nb1LlnaCZrHVethI2kg+WZ3DCyyXpABJZFuWC6iyCgbaCsfk0LjOUjHrEcA=
X-Gm-Gg: ASbGnctB8TdqlZDms2MGmZjYzCUjQFUhdibPZCjSgPplI0e7/igXrfEvmbyxQnXgDgu
	p9q2QSgEUOsXW3JgxSv6St6G9+NIpFbWa6zwoTb+YUZv7qhaM3kP6p08Cufhie4Nhn5wn78A14T
	mzKCXDfDjAh5fJa/DZO5g5jNAfslXoAQnwg7DnIrmJfYZqrBaNNeOWHU43bbLPsyXHAc/ZWu42O
	t3CHPE+J13atuZZ8y4U46wRe5RsZYNMio+YPnZRFycL0+ywp/mtTg==
X-Google-Smtp-Source: AGHT+IGYH4zeaZiE7s4YcdQPS+jXDgKkEuUNU8+eF5sMaKEAwGSy6gVFnffZH3wiZ30aAyYxGMCatg==
X-Received: by 2002:a5d:47cb:0:b0:382:4b5e:5244 with SMTP id ffacd0b85a97d-385fd3f2432mr1531946f8f.7.1733294779809;
        Tue, 03 Dec 2024 22:46:19 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155da906f2sm70317925ad.87.2024.12.03.22.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 22:46:19 -0800 (PST)
Message-ID: <79b86b7b-8a65-49b8-aa33-bb73de47ad37@suse.com>
Date: Wed, 4 Dec 2024 14:46:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, Heming Zhao <heing.zhao@suse.com>,
 stable@vger.kernel.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-2-heming.zhao@suse.com>
 <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 11:47, Joseph Qi wrote:
> 
> 
> On 12/4/24 11:32 AM, Heming Zhao wrote:
>> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
>> unmounting an ocfs2 volume").
>>
>> In commit dfe6c5692fb5, the commit log stating "This bug has existed
>> since the initial OCFS2 code." is incorrect. The correct introduction
>> commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
>>
> 
> Could you please elaborate more how it happens?
> And it seems no difference with the new version. So we may submit a
> standalone revert patch to those backported stable kernels (< 6.10).

commit log from patch [2/2] should be revised.
change: This bug has existed since the initial OCFS2 code.
to    : This bug was introduced by commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")

----
See below for the details of patch [1/2].

following is "the code before commit 30dd3478c3cd7" + "commit dfe6c5692fb525e".

    static int ocfs2_sync_local_to_main()
    {
    	... ...
  1  	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
  2  	       != -1) {
  3  		if ((bit_off < left) && (bit_off == start)) {
  4  			count++;
  5  			start++;
  6  			continue;
  7  		}
  8  		if (count) {
  9  			blkno = la_start_blk +
10   				ocfs2_clusters_to_blocks(osb->sb,
11   							 start - count);
12
13   			trace_ocfs2_sync_local_to_main_free();
14
15   			status = ocfs2_release_clusters(handle,
16   							main_bm_inode,
17   							main_bm_bh, blkno,
18   							count);
19   			if (status < 0) {
20   				mlog_errno(status);
21   				goto bail;
22   			}
23   		}
24   		if (bit_off >= left)
25   			break;
26   		count = 1;
27   		start = bit_off + 1;
28   	}
29
30 	/* clear the contiguous bits until the end boundary */
31 	if (count) {
32 		blkno = la_start_blk +
33 			ocfs2_clusters_to_blocks(osb->sb,
34 					start - count);
35
36 		trace_ocfs2_sync_local_to_main_free();
37
38 		status = ocfs2_release_clusters(handle,
39 				main_bm_inode,
40 				main_bm_bh, blkno,
41 				count);
42 		if (status < 0)
43 			mlog_errno(status);
44  	}
    	... ...
    }

bug flow:
1. the left:10000, start:0, bit_off:9000, and there are zeros from 9000 to the end of bitmap.
2. when 'start' is 9999, code runs to line 3, where bit_off is 10000 (the 'left' value), it doesn't trigger line 3.
3. code runs to line 8 (where 'count' is 9999), this area releases 9999 bytes of space to main_bm.
4. code runs to line 24, triggering "bit_off == left" and 'break' the loop. at this time, the 'count' still retains its old value 9999.
5. code runs to line 31, this area code releases space to main_bm for the same gd again.

kernel will report the following likely error:
OCFS2: ERROR (device dm-0): ocfs2_block_group_clear_bits: Group descriptor # 349184 has bit count 15872 but claims 19871 are freed. num_bits 7878

thanks,
Heming

