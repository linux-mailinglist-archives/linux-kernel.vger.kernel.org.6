Return-Path: <linux-kernel+bounces-294042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786195882A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81FB2848F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F8190685;
	Tue, 20 Aug 2024 13:45:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286D19046E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161501; cv=none; b=TsMWktgLLzCx5/gOi3R3N2ndQamYsy1Y4Wogzej6JwiS9KowIwGV/3lOIVMMsF3GsjuGxr336O1jvsmVzAJskf3fZhSL1bGImSaVZOQ8XOdXLVChjgeQCcn0BARqnKmCl6xctNMG1rX5LRakTf2/kcEa8R1wx7oigP9mNjM222g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161501; c=relaxed/simple;
	bh=CWXuHPefhdqwaAJThsUE0vknzNBQK4V4XCLNmW4PqE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7oGmRAkWz/dNwpyYp7iVnmYohPRTyVO0fgPMg2Bgwh90wqHe0b4y7T9A06GvjVefdY36GcYHmtpwXsIl5RvQ0Dn1qb1WCZtUy5npTaZ72Of/yX1nKgvpssZuGbEwyuIc9sMAsRumbX8DCMuWzSK3XoML661NZ6worR9D+0C5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K4UoKC024085;
	Tue, 20 Aug 2024 06:44:34 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412uck2nmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Aug 2024 06:44:34 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:44:33 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 06:44:31 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <heming.zhao@suse.com>
CC: <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <mark@fasheh.com>, <ocfs2-devel@lists.linux.dev>,
        <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ocfs2: remove unreasonable unlock
Date: Tue, 20 Aug 2024 21:44:30 +0800
Message-ID: <20240820134430.278418-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e6f16317-6d11-4f14-ba88-6c7b33276285@suse.com>
References: <e6f16317-6d11-4f14-ba88-6c7b33276285@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SIcQV/vH c=1 sm=1 tr=0 ts=66c49dc2 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=yoJbH4e0A30A:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=nRLMoZkPJ-_k_nL0rzoA:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: wvaevm_1xoCISi8ewTkX2_xohP6QzOUy
X-Proofpoint-GUID: wvaevm_1xoCISi8ewTkX2_xohP6QzOUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=409 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408200102

On Tue, 20 Aug 2024 19:32:03 +0800, Heming wrote:
> > In the for-loop after the 'read_failure' label, the condition
> > '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
> > When this contidion is true, this for-loop will call ocfs2_set_buffer
> > _uptodate(ci, bh), which then triggers a NULL pointer access error.
> >
> > Changes from V2:
> > * Make the code more concise
> >
> > Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> 
> I didn't give you my "Reviewed-by" tag for this patch, and you
> can add my tag only after I send it to you.
> (take easy, you can get my "Reviewed-by" tag now.)
> Please remember this rule for next time.
Got it.
> 
> Another issue with this mail is that the change log should be
> placed before the file list, not in the commit message section.
Thanks. Its like following:
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V2 -> V3: Make the code more concise

 fs/ocfs2/buffer_head_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

BR,
Lizhi

