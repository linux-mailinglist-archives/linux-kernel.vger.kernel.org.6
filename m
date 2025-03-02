Return-Path: <linux-kernel+bounces-540194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DCA4AF48
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 05:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7983B20D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 04:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA81B6D06;
	Sun,  2 Mar 2025 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/iaDN3G"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B618D643
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740890491; cv=none; b=l3DizEa5HEOwUo/lG+Fv8Oa3iRfvJdZatvZWHBgj8VX8Jg8Xdcl9gcWhXNHZtnHPgkF9uhIZelz9Auq8Nrnp0/wru8P0mwOXPTR/1GYqF1tMq9xGozCMwNv0hsZ61ES0KTFXc7UvgoLJNIGJ1KXAJ5SdgRz1l6qVh6e2CmgCwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740890491; c=relaxed/simple;
	bh=Pvdp7Qq96UfC/x2+ZmnML63OHPWkiPRQWVhW+KMSxE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQVzk3NL6+l5Zpjzg7Ckqe4qFo5/pRIOmZ1SPBUnFCZw7ZbupPuwRzAkVMg3jvz/yOhxG4hv/d08njjkaPO+/rTJz6ecJ+P6gr2RikgD89s1UCPOSV/xR3SfdjnW3LNZyTC031uAt3iqG/6QiKHtKIruvf+LHWj9M+oHyx8g038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/iaDN3G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5221VAUb011444;
	Sun, 2 Mar 2025 04:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CoWBOv
	ObzL9EJVp8HByGX04v1bDxGEY88MLNLpRCCo8=; b=N/iaDN3GxctjIZduhn5NbQ
	glCFkPfAA2UsJc1yhsW84kCDDFjtuILt4UmOpBM1O3egu3yHwau+maDmtEILbQiQ
	Ir/NjqFNi7BEI/Fzw92jxPEJT1y90+riEq2z6/kf5qvIL4cnxi6wovSLfJEDCJPK
	TOL/TE6YlD8FCTupit5/r+fjAWP7pBsKm39/CGxfW6JuR2JF8G7KwmYe+i4bRy82
	ZM1s8X8C3FEtWFxg9ESW5NPY+Anqa9FDnf9hJq6/5t65Y/5nY/1wwDYBF84oL4ZQ
	k2ihAwaywgghtwyxzJTcGZOxRssSgpyrdPcxSTLejS79jbVGzDUAtq5HZzBgz0Tw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4542912s5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 04:40:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5224ejrY002364;
	Sun, 2 Mar 2025 04:40:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4542912s5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 04:40:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5222gSme020824;
	Sun, 2 Mar 2025 04:40:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjgc5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 04:40:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5224egL147841734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 04:40:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4D720043;
	Sun,  2 Mar 2025 04:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1609220040;
	Sun,  2 Mar 2025 04:40:34 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.83.152])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Mar 2025 04:40:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/4] Implement inline static calls on PPC32 - v4
Date: Sun,  2 Mar 2025 10:10:30 +0530
Message-ID: <174089027712.25244.560287768025207621.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZ2PXWMrXkueT3DsQbLJaaMGmDo63Vt1
X-Proofpoint-ORIG-GUID: 3TyE20V3wWsdYlKZuNDbwQjw2LbM90L5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_10,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 phishscore=0 mlxlogscore=670 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503020031

On Tue, 03 Dec 2024 20:44:48 +0100, Christophe Leroy wrote:
> This series implements inline static calls on PPC32.
> 
> First patch adds to static_call core the ability to pass the
> trampoline address at the same time as the site address to
> arch_static_call_transform() so that it can fallback on branching to
> the trampoline when the site is too far (Max distance for direct
> branch is 32 Mbytes on powerpc).
> 
> [...]

Applied to powerpc/next.

[1/4] static_call_inline: Provide trampoline address when updating sites
      https://git.kernel.org/powerpc/c/d856bc3ac7d9ca88b3f52d8e08e58ce892dc3ce1
[2/4] objtool/powerpc: Add support for decoding all types of uncond branches
      https://git.kernel.org/powerpc/c/bb7f054f4de260dc14813230cfe4ca7299647b6e
[3/4] powerpc: Prepare arch_static_call_transform() for supporting inline static calls
      https://git.kernel.org/powerpc/c/6626f98ed55a7a20b1852e7d263a96d8f5a1b59f
[4/4] powerpc/static_call: Implement inline static calls
      https://git.kernel.org/powerpc/c/f50b45626e053dc10792c680cabbbadbf8c001e7

Thanks

