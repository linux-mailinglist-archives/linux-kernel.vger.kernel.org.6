Return-Path: <linux-kernel+bounces-559956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38CA5FBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E53A97E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575A26A086;
	Thu, 13 Mar 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XRifKj/6"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA8269CEC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883004; cv=none; b=s45/X+El7ydzrIauhyrIM2jMEC/FIQ+zGtCzAIk5oRf0MIBkUoHgASpN7oDhaHUCNv8DQOgKprcgldk1EvImmqBKsNcH1f7tLC/sCjkNMWNW+OBOGSIOXe2fdDdu32dSCB+E8nbN4eypBoVFH8gheRbXz30v0TlOtf6yYIY3mhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883004; c=relaxed/simple;
	bh=l5Bu+TyRNUWlmGj5EcMKN9XpyeX6l5pAcSIM2YB0SJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPTYJ2gMBWQ8d+EeGy3eRvCMK2Tzz3tjrs+M7OOM4fbqcdDyhH6og2CBhRAoOj/xG/NdOlUi84tzxVOUyPo20AXXjWbtWtBe2tniqGsR60tk9E1b7MX5q7P84RzpqAmAnNWpKOzEyeecI73bsFNB1CAXAgnabsqeYsQOoQa8PKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XRifKj/6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c54c52d8easo247697485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741883002; x=1742487802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrRFUJhkeyaL1R2Vv0+vn3p6ZJnpUo2ZC2Z7tEGAZfw=;
        b=XRifKj/6NoYLbHvC701UzsyhxZSTvFSeO1lVMk2NpESGpCaKV3EcC5mGeTClMgHQn7
         PMt9mxPlKbQbLeqKw8Q6jvOWMh55gQefjLdK6QnDBNs/VnycTJ2wOUGN0xMdc7mxjxUi
         0x1wuRlzmokhZLE/1Pw1OmvRWbS0puaPU8olfH43w++S/lskaGGgABJ7d0RAS2gyCuHO
         GQaA52KaaZ4aotNe4h0DzslNBL2CGLX78irH3KRoxjpTGcRL3XdfzIeKicAEiizdDkx2
         37okxbG36tf9yWxqc5DMJeepcBDvOVl513iB2X7T58XC85+ygDLMk0diu8GhvZwtYsWW
         1ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883002; x=1742487802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrRFUJhkeyaL1R2Vv0+vn3p6ZJnpUo2ZC2Z7tEGAZfw=;
        b=iNpSwVX3QpU3Sj4BFSHZcYW60miQ/NJLEd1MWk6raNWTbwNCe6zGpVUz3EjbxleVeC
         79HCWO/1anrd9TlHPMHgBl4r6i8ADllbUlvFluJ/IKMowhd9x1vdQye0SWfzAYj5HZo9
         COoWHrK/4p74d6RU9GwMb/lzGYQ1mEms5S2aYfGmCUM6BS0CQNMfy06azXrOdhjiHF7r
         yMfPv+Z3BZ7/Zvvyk1PqDcwkgrqa3xCcl4dur7zDyChA2wTFY7RDrHLHt91G7GlZwnsY
         SEyHp/8Gq8V0NQHGQFNs6aOV/TI46QZctvLr+WwIE3LycHkvnn8Q+32KWuAMfYnSl8h6
         FtMg==
X-Forwarded-Encrypted: i=1; AJvYcCWcE1513/FxmgOQf5tGpBTJTaNgxBl4j9I4MtQUcDlXZzXnDwfpidaEcj/EpwF7sZ7wIq7piGcD4uRL5HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTkga9lFVDbOt1pQ5JaJxIKcI/FVvL2wr6eW+/8N3aIL9K686
	UIbMVeKxhj5H28ilacj7veH6QjtPEnRQP9cLtxOSvynrcxgs+AHjfhyCisqD1rc=
X-Gm-Gg: ASbGncs+duQ6YAyAyOLjlOI7HKZilhBX10w1ed60oklZ4N8MAZOnh9Jt2llSn4M9Ac2
	VbaHr5gWe2jf0TaEO0K4K6D0kb4oGqm+9wBHSgnWjcvuT43Oac+x0TJZ4ejeZJqGYE6Ks1Chzsl
	Bgn3vu5dVYSFBUmbvpkiMWzEE/WiOik561G2XQdwEzr7FLScnKDV/FhW1u63Ca8GiNYrKGJHzaz
	mRNKH48yCZx4tjD+36tlzbz/D3i3gjf5wiIVGe2BZ+Mk6t4eFpY8zJVf3UspWScTfaRTJiAn73N
	fXjlQODqcGVoiAjD2lqtarjV+2dV1zQi+iFkbrwA4KXcIJIZwd2jbQ62+361dnWF5DLqUjfM2aR
	r/DMwnMME5NlEhyd2zmRFhWH3hJw=
X-Google-Smtp-Source: AGHT+IFmSrDkHOW9CD4C+SfuWoYsDhx22Nfs217sGKgO8g7l8OBfmKzMb0gcROREHfpiz274St3PtA==
X-Received: by 2002:a05:620a:8323:b0:7c5:3da4:5bcb with SMTP id af79cd13be357-7c57376cde3mr447561585a.10.1741883001932;
        Thu, 13 Mar 2025 09:23:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573da455dsm114957785a.115.2025.03.13.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:23:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:23:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com, david@redhat.com
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z9MGdwrgX8dYeHha@gourry-fedora-PF4VCD3F>
References: <Z9GwNWNC9VfR3Y6A@gourry-fedora-PF4VCD3F>
 <20250313063351.692-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063351.692-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:33:37PM +0900, Rakie Kim wrote:
> > I'm fairly certain this logic is wrong.  If I add two memory blocks and
> > then remove one, would this logic not remove the sysfs entries despite
> > there being a block remaining?
> 
> Regarding the assumption about node configuration:
> Are you assuming that a node has two memory blocks and that
> MEM_OFFLINE is triggered when one of them is offlined? If so, then
> you are correct that this logic would need modification.
> 
> I performed a simple test by offlining a single memory block:
> # echo 0 > /sys/devices/system/node/node2/memory100/online
> 
> In this case, MEM_OFFLINE was not triggered. However, I need to
> conduct further analysis to confirm this behavior under different
> conditions. I will review this in more detail and share my
> findings, including the test methodology and results.
>

+David - might have a quick answer to this.  I would have expected a
single memory block going offline to cause a notification.


I think the logic we care about is here:

static void node_states_check_changes_online(unsigned long nr_pages,
        struct zone *zone, struct memory_notify *arg)
{
        int nid = zone_to_nid(zone);

        arg->status_change_nid = NUMA_NO_NODE;
        arg->status_change_nid_normal = NUMA_NO_NODE;

        if (!node_state(nid, N_MEMORY))
                arg->status_change_nid = nid;
        if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
                arg->status_change_nid_normal = nid;
}

static void node_states_set_node(int node, struct memory_notify *arg)
{
        if (arg->status_change_nid_normal >= 0)
                node_set_state(node, N_NORMAL_MEMORY);

        if (arg->status_change_nid >= 0)
                node_set_state(node, N_MEMORY);
}

int online_pages(unsigned long pfn, unsigned long nr_pages,
                       struct zone *zone, struct memory_group *group)
{
	...
        node_states_check_changes_online(nr_pages, zone, &arg);
	...
        node_states_set_node(nid, &arg);
	...
        memory_notify(MEM_ONLINE, &arg);
}

In the callback i think you want to check whether N_MEMORY is set

+	case MEM_OFFLINE:
++              if (node is !N_MEMORY)
++			sysfs_wi_node_release(node_attrs[nid], wi_kobj);
+		break;
+	}

Similar with online (don't want to double-add).


also from what I can tell, N_MEMORY implies N_ONLINE because N_ONLINE
occurs when memory blocks are added (regardless of state).

~Gregory 

