Return-Path: <linux-kernel+bounces-438726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DD59EA4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2972C168F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3A1B4229;
	Tue, 10 Dec 2024 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyckgdPM"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232419C556
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796652; cv=none; b=Mn3tPEcNQBzwdSciNMJt6T+9FRvr0JXADwdszktpMcYOT1qiZ5UO5WksmKNoefrwgHQCSP+ucE9LZI8RCjyPTCYA2UtKQgDHhYsyPYw2/dnerUneix6DviABDmSeCl5FVJ/LPHjSx3f0K/aY0GI5HmUeCcZRJjkhuRHP7DzNCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796652; c=relaxed/simple;
	bh=135zj6Vs2QboV1ZkH+27L/6JSX0hs88rYpxZXnEagAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R60yhkjE8yEg/n9e7moxaxlgU6fcuXA+awgmeLk3qxWqkw0SSLA0xhlsq38dUE2pvmT6HXX5k//t3PJTwbl7/nC7oevABk/mNuaEsRpuUtc/FBRrA3rFO3dcHTvUIHtl1GRBkvXskqxFvbuboD/5sGc+/HZgCEm4+TKOD1OUzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyckgdPM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ef0397aeso1404688b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733796650; x=1734401450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLJRIOjrLeAL5wIUJuZEaoadinY/F2XEHffeTOJtLus=;
        b=QyckgdPMlTimpS1ndfRLUS7GqmxZB6WitZteqC/dqGWWv2HE3jwAKlBHv7niNvdX5r
         Dk7YOalo407OtefZ3oLLxtES3dDhbGpM64antkS2JyylRvCWMjWP2SsVIu7dDsnthIl4
         pD4YR9Ejpxe+tRBWoOXoZRzGzpdkounR9nNLvl3MMTxW0wjcAe3iPOSJYGpY46+qna/u
         xiBwwilPJ8r/0iNEZw5NE1XPVZGZXDoj6nO3NoBHCwdXp7T/3jj0xVNw5Qz7JhjBVvL7
         FuiWo/ntvC2ppGrOqQx5GeQ2+zjBnb7P+XaNNM+9u1MiGwCh8PSt4pgTsvLXilGI0jN6
         DRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733796650; x=1734401450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLJRIOjrLeAL5wIUJuZEaoadinY/F2XEHffeTOJtLus=;
        b=TYKxeYzqubnNLoqq+4zHkgSouSMITBdR0nM35bBbl78ZCWKT2EWPxxGSzReTYBXU7F
         jIUcaZKxc5XLrDsx5W6n9I6g2pNde2iTeOKH0juQrKjf8QRRRXEgnerRW25smD1UT2rH
         DivnHMX4QKqvxs/GbQF0NTNJC6Wm4Kyp+Ff10CeFBNvErbJxSYWAf9s3DfmGXMzeTtA5
         deX7ba9aJ0ShbuYqBmkvjSxK/CiYfQGxyrTo05nWmqS9svYUheAEpT3MS/SxLCQ88PHS
         pNw0bSpWQ7S5b2lMrWUS+ITuZys0yF5q3ahG5fYxZku4m2VHyHV1JNAGQsuCXGTbaNB2
         hECw==
X-Forwarded-Encrypted: i=1; AJvYcCWu7FG3FSA/89Yw9NmjeRdJX+67XLYI+a3aOQ52KENKzTzlH4eq6VGc50/HREEkHzfYIRISYI2shmdgts0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX3Zf/0t6dcyDaz1t0WDJyjNzfcLAY/rRzEyy5HlJSw/plHp1
	xaF7kYBB3eQLOepVbHMf8ACZKKtmoKKeYxgDNtOlgTu+hTSp7nhg
X-Gm-Gg: ASbGnctLR+d2jq3SfNeQ3uk+Mx4ezp7A8u7bHHzx/pZFBm4eDwrpNlW0dc8khkeIWvg
	vBJ8klF8FEN1Rwnl2f7I4Af0R1K0xOwnP6ctCUFIQB+gKejGlaFFJjPcrgN0PBpVuPkWTPMN0sV
	ftpj8xbURDSTBu8R7Mfo9EM4z9/x0hun/ngoGCFDIdBnOCu8UsLT/4NpReLRImfgEqeTiuuni5n
	V07Yz63YUUq5ypFrFzGNcstjTtaHpiiIyxUeXqHfgT3UgqVhVwGWg==
X-Google-Smtp-Source: AGHT+IE1eCjvx+ZW/bJqxVlfgKGPa/+yK4gGPVQincDvsSXpSoFsveySxAWOsaF1De7/O0bvhVpv3A==
X-Received: by 2002:a05:6a00:170d:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-725b7ee4d60mr20078561b3a.0.1733796649732;
        Mon, 09 Dec 2024 18:10:49 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ec158d1csm2785102b3a.91.2024.12.09.18.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 18:10:48 -0800 (PST)
Date: Mon, 9 Dec 2024 18:10:45 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1ejJSBes62otQ0k@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
 <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
 <Z1eH8_rP16IyJ8LI@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1eH8_rP16IyJ8LI@gpd3>

On Tue, Dec 10, 2024 at 01:14:43AM +0100, Andrea Righi wrote:
> > And altogether this should look like:
> > 
> >  int scx_pick_idle_cpu_from_hop(struct cpumask *hop_cpus, struct cpumask *cpus_allowed)
> >  {
> >          int node, cpu, random_cpu;
> > 
> >          do {
> > 
> >                  /* Pick a 'random' CPU in the hop */
> >                  random_cpu = cpumask_any_and_distribute(hop_cpus, cpus_allowed);
> >                  if (random_cpu >= nr_cpu_ids)
> >                          continue;
> > 
> >                  node = cpu_to_node(random_cpu);
> > 
> >                  /* Find an idle CPU in the same node */
> >                  cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> >                  if (cpu >= 0)
> >                          break;
> > 
> >                  /* No luck? Try other nodes */
> >          } while (cpumask_andnot(hop_cpus, hop_cpus, cpumask_of_node(node)));
> > 
> >          return cpu;
> >  }
> > 
> >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
> >  {
> >         const struct cpumask *next, *prev = cpu_none_mask;
> >         int prev_node = cpu_to_node(prev_cpu);
> >  ...
> > 	for_each_numa_hop_mask(next, prev_node) {
> >                 cpumask_andnot(hop_cpus, next, prev);
> >                 cpu = scx_pick_idle_cpu_from_hop(hop_cpus, cpus_allowed);
> >                 prev = next;
> >         }
> >  ...
> >  }
> > 
> > Not tested, but should work.
> 
> Makes sense to me, I'll do some testing with this.

One thing you can do to optimize it is introducing a function that
pulls nodes from the hop_cpus:

 void sched_get_hop_nodes(nodemask_t *hop_nodes, const struct cpumask *hop_cpus)
 {
        int cpu;

        for_each_cpu(cpu, hop_cpus) {
               node_set(cpu_to_node(cpu);, hop_nodes);
               cpu = cpumask_next_zero(cpu, cpumask_of_node(node)
        }
 }

This should be O(N), but it will let you to avoid O(N*M) in the loop
condition inside scx_pick_idle_cpu_from_hop():

 int scx_pick_idle_cpu_from_hop(nodemask_t *hop_nodes, struct cpumask *cpus_allowed)
 {
        int node, idle_cpu, random_cpu;

        for_each_node_mask(node, &hop_nodes) {
                /* Pick a 'random' CPU in the node */
                random_cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
                if (random_cpu >= nr_cpu_ids)
                        continue;

                /* Find an idle CPU in the same node */
                idle_cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
                if (idle_cpu >= 0)
                        break;

        }

        return cpu;
 }

And at this point I'd also compare the above with non-randomized
version:

 static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
 {
        const struct cpumask *next, *prev = cpu_none_mask;
        int prev_node = cpu_to_node(prev_cpu);
        nodemask_t hop_nodes;
 ...
	for_each_numa_hop_mask(next, prev_node) {
                if (!cpumask_and_andnot(hop_cpus, next, cpus_allow, prev))
                        goto cont;

                sched_get_hop_nodes(hop_nodes, hop_cpus);
                for_each_node_mask(node, hop_nodes) {
                        cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
                        if (cpu >= 0)
                                goto found;
                }

        cont:
                prev = next;
        }
 ...
 }

Don't know how it works, but it looks really good.

Thanks,
Yury

