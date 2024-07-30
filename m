Return-Path: <linux-kernel+bounces-266807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF39407F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6CE1C223FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB816B3A5;
	Tue, 30 Jul 2024 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt6Ofdin"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAA18A951
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318888; cv=none; b=cTv/QrHcg6ZBLE8THD7nIDyyi8NoMyaVJhfp+lV8h7sIeifRcAFEPd0VzsJAkhCmRC1O/Zqzfkstj2IHaUPJ2ytRptKXHDI7QTdCce4LEZWaHQEuWpZ69HeGxHvjW4UoamIDhIk2Hd9c66Yb52SYLV8SI6aTVGRtKctoMOLDjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318888; c=relaxed/simple;
	bh=LepwoDgIuCy+uoQzloUJnU7JY15hYNSe7w9c6cTQOwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sD7LqG6GXczPYG6jCUhyKdNGyU5LQyjaIoaQcsJ+zM3BxlNBZWuZ/HvK+PUC5hc6eDZEjl4n5c9Y6RTamQd6HLbimYvFQes/wCaiPBM1d2ubZumkRa65PASm2G+Q0sxJCdJ8ctev90iwJvk6mEnZ37R/kTtURSXqvWnuUIL3bP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt6Ofdin; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so54556511fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722318885; x=1722923685; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5pPiHt6oGh1byOIgWfpIT3E6J4N4/NPdLe4lpCZVsA=;
        b=lt6Ofdinl6m7BFy83mM2t7cgsSsAnCqQ98uUOkCYOwC2n+R81LUnLv4IppOmoLQVwz
         knAmins6JZuSrPBlV6MnrTVll8wV/ZQCmBgSRmol9qU6iJ+JISdCSufQLZBZ3XgY7tH9
         Q6saR4CL6CP5k5/TSGc9rXB2p6Q9Oj+TWN0PKt6pKgGwg1BaiDZQi2/W1S4f4x4x4vSh
         HNsF3eOFI4DpSejNdKl7QpDhC7d2jl6OgzCyHIfh48TxwOblUY4Z0GAHvI+ikKQ6wGrA
         420GK8lx45IyryYEBzhb7iz+xy3H+5zLlWHfB+U3L9kSAb/FnOQQUIwIAD4jpWsgOXM/
         QxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722318885; x=1722923685;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5pPiHt6oGh1byOIgWfpIT3E6J4N4/NPdLe4lpCZVsA=;
        b=iv1+Yo/d22g5116AUV9kmN1F0wq/2FJXVIf09hfjjjhrZBZFAjcpibATxtp88Adgbt
         W7Ccs8LcMQOlOYkxAufWTaB3TRdq0zZTiMk64H9UdvzQQD43d8kVWnkQCg0vtJe790Jr
         czWlPmqF0v9xNva0iJMVgnKmeHnKwGdQChDLHTMW7Qufn8jv+Ncdf4YUyEnhRwrZhnTA
         1BLXoUk8Fn2QJ6q5ovNdZWdQVMSnWVdn58/aFvRpagdMVkQvvZIQ6vD0cAjPtTPipquv
         ziyVt8VChDrKHBM+PgM2BcH9iISVvsNpucxLamxpw+Pe7Sf3zvqahFIgEGeOhl1R/iTH
         IZ6w==
X-Gm-Message-State: AOJu0YwQS2wIsYcU7CaW6xFROlNA+IDyg1ny2XKyMQjUsGyaJlQKIEnd
	3GiCgaGb/g+3XZs/O8zGryIHZ30rrO63geZMT7BCn9GnkO0cTF90
X-Google-Smtp-Source: AGHT+IFC/ZJDwRehfBeDBQHgs+DGb0guHlkQl0EEJRi5zcmio4d5grksjwaM9roMaqh/pRCwBGSL+g==
X-Received: by 2002:a2e:8495:0:b0:2ef:5d1d:773f with SMTP id 38308e7fff4ca-2f12edd6cb4mr72061701fa.24.1722318884320;
        Mon, 29 Jul 2024 22:54:44 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af2f233be4sm5474560a12.41.2024.07.29.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 22:54:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 30 Jul 2024 07:54:37 +0200
Subject: [PATCH v2] clang-format: Update with v6.11-rc1's `for_each` macro
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-clang-format-for-each-macro-update-v2-1-254fca862c97@gmail.com>
X-B4-Tracking: v=1; b=H4sIAByAqGYC/5WNQQ6CMBBFr0Jm7RioIKkr72FYTIYBJqGUtEg0h
 LtbuIGrn/cX720QJahEeGQbBFk1qp8SmEsGPNDUC2qbGExuyrw2FnlML3Y+OFqOQSEe0BEHj++
 5pUXwnpcitWUyliCJ5iCdfs7Iq0k8aFx8+J7NtTjev/RrgQVarqpSuBO+ybN3pOOVvYNm3/cfy
 UGiI9QAAAA=
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722318883; l=7409;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LepwoDgIuCy+uoQzloUJnU7JY15hYNSe7w9c6cTQOwc=;
 b=QJfKIciAtBzlxJ0fRAjsTZHfxt+HXEAgMOFhT8Wv4SDcsenqXkx9iHa8XaYt3yKyxX7cpVKdM
 yX/wCfG3EccBijnrLtJoZLX602AW1WnCpvxL6TnSixheU/Bak7cvWgy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Re-run the shell fragment that generated the original list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Note that commit 4792f9dd1293 ("clang-format: Update with the latest
for_each macro list") added the macro `displayid_iter_for_each`, which
is not part of include/ and tools/ (it is defined in
drivers/gpu/drm/drm_displayid_internal.h), and the shell fragment used
to update the list will drop it. In order to keep the macro on the list,
manual intervention will always be required.
---
Changes in v2:
- Drop `displayid_iter_for_each` (moved to internal header).
- Link to v1: https://lore.kernel.org/r/20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com
---
 .clang-format | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/.clang-format b/.clang-format
index 252820d9c80a..fe1aa1a30d40 100644
--- a/.clang-format
+++ b/.clang-format
@@ -141,11 +141,13 @@ ForEachMacros:
   - 'damon_for_each_target_safe'
   - 'damos_for_each_filter'
   - 'damos_for_each_filter_safe'
+  - 'damos_for_each_quota_goal'
+  - 'damos_for_each_quota_goal_safe'
   - 'data__for_each_file'
   - 'data__for_each_file_new'
   - 'data__for_each_file_start'
   - 'device_for_each_child_node'
-  - 'displayid_iter_for_each'
+  - 'device_for_each_child_node_scoped'
   - 'dma_fence_array_for_each'
   - 'dma_fence_chain_for_each'
   - 'dma_fence_unwrap_for_each'
@@ -172,11 +174,14 @@ ForEachMacros:
   - 'drm_for_each_plane'
   - 'drm_for_each_plane_mask'
   - 'drm_for_each_privobj'
-  - 'drm_gem_for_each_gpuva'
-  - 'drm_gem_for_each_gpuva_safe'
+  - 'drm_gem_for_each_gpuvm_bo'
+  - 'drm_gem_for_each_gpuvm_bo_safe'
   - 'drm_gpuva_for_each_op'
   - 'drm_gpuva_for_each_op_from_reverse'
+  - 'drm_gpuva_for_each_op_reverse'
   - 'drm_gpuva_for_each_op_safe'
+  - 'drm_gpuvm_bo_for_each_va'
+  - 'drm_gpuvm_bo_for_each_va_safe'
   - 'drm_gpuvm_for_each_va'
   - 'drm_gpuvm_for_each_va_range'
   - 'drm_gpuvm_for_each_va_range_safe'
@@ -192,11 +197,11 @@ ForEachMacros:
   - 'dsa_switch_for_each_port_continue_reverse'
   - 'dsa_switch_for_each_port_safe'
   - 'dsa_switch_for_each_user_port'
+  - 'dsa_switch_for_each_user_port_continue_reverse'
   - 'dsa_tree_for_each_cpu_port'
   - 'dsa_tree_for_each_user_port'
   - 'dsa_tree_for_each_user_port_continue_reverse'
   - 'dso__for_each_symbol'
-  - 'dsos__for_each_with_build_id'
   - 'elf_hash_for_each_possible'
   - 'elf_symtab__for_each_symbol'
   - 'evlist__for_each_cpu'
@@ -216,6 +221,7 @@ ForEachMacros:
   - 'for_each_and_bit'
   - 'for_each_andnot_bit'
   - 'for_each_available_child_of_node'
+  - 'for_each_available_child_of_node_scoped'
   - 'for_each_bench'
   - 'for_each_bio'
   - 'for_each_board_func_rsrc'
@@ -234,6 +240,7 @@ ForEachMacros:
   - 'for_each_card_widgets_safe'
   - 'for_each_cgroup_storage_type'
   - 'for_each_child_of_node'
+  - 'for_each_child_of_node_scoped'
   - 'for_each_clear_bit'
   - 'for_each_clear_bit_from'
   - 'for_each_clear_bitrange'
@@ -251,6 +258,7 @@ ForEachMacros:
   - 'for_each_cpu'
   - 'for_each_cpu_and'
   - 'for_each_cpu_andnot'
+  - 'for_each_cpu_from'
   - 'for_each_cpu_or'
   - 'for_each_cpu_wrap'
   - 'for_each_dapm_widgets'
@@ -269,13 +277,14 @@ ForEachMacros:
   - 'for_each_element'
   - 'for_each_element_extid'
   - 'for_each_element_id'
+  - 'for_each_enabled_cpu'
   - 'for_each_endpoint_of_node'
   - 'for_each_event'
   - 'for_each_event_tps'
   - 'for_each_evictable_lru'
   - 'for_each_fib6_node_rt_rcu'
   - 'for_each_fib6_walker_rt'
-  - 'for_each_free_mem_pfn_range_in_zone'
+  - 'for_each_file_lock'
   - 'for_each_free_mem_pfn_range_in_zone_from'
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
@@ -286,15 +295,18 @@ ForEachMacros:
   - 'for_each_group_member'
   - 'for_each_group_member_head'
   - 'for_each_hstate'
+  - 'for_each_hwgpio'
   - 'for_each_if'
   - 'for_each_inject_fn'
   - 'for_each_insn'
+  - 'for_each_insn_op_loc'
   - 'for_each_insn_prefix'
   - 'for_each_intid'
   - 'for_each_iommu'
   - 'for_each_ip_tunnel_rcu'
   - 'for_each_irq_nr'
   - 'for_each_lang'
+  - 'for_each_link_ch_maps'
   - 'for_each_link_codecs'
   - 'for_each_link_cpus'
   - 'for_each_link_platforms'
@@ -332,6 +344,9 @@ ForEachMacros:
   - 'for_each_new_plane_in_state_reverse'
   - 'for_each_new_private_obj_in_state'
   - 'for_each_new_reg'
+  - 'for_each_nhlt_endpoint'
+  - 'for_each_nhlt_endpoint_fmtcfg'
+  - 'for_each_nhlt_fmtcfg'
   - 'for_each_node'
   - 'for_each_node_by_name'
   - 'for_each_node_by_type'
@@ -387,12 +402,15 @@ ForEachMacros:
   - 'for_each_reloc_from'
   - 'for_each_requested_gpio'
   - 'for_each_requested_gpio_in_range'
+  - 'for_each_reserved_child_of_node'
   - 'for_each_reserved_mem_range'
   - 'for_each_reserved_mem_region'
+  - 'for_each_rtd_ch_maps'
   - 'for_each_rtd_codec_dais'
   - 'for_each_rtd_components'
   - 'for_each_rtd_cpu_dais'
   - 'for_each_rtd_dais'
+  - 'for_each_rtd_dais_reverse'
   - 'for_each_sband_iftype_data'
   - 'for_each_script'
   - 'for_each_sec'
@@ -533,8 +551,6 @@ ForEachMacros:
   - 'lwq_for_each_safe'
   - 'map__for_each_symbol'
   - 'map__for_each_symbol_by_name'
-  - 'maps__for_each_entry'
-  - 'maps__for_each_entry_safe'
   - 'mas_for_each'
   - 'mci_for_each_dimm'
   - 'media_device_for_each_entity'
@@ -560,7 +576,9 @@ ForEachMacros:
   - 'netdev_hw_addr_list_for_each'
   - 'nft_rule_for_each_expr'
   - 'nla_for_each_attr'
+  - 'nla_for_each_attr_type'
   - 'nla_for_each_nested'
+  - 'nla_for_each_nested_type'
   - 'nlmsg_for_each_attr'
   - 'nlmsg_for_each_msg'
   - 'nr_neigh_for_each'
@@ -579,6 +597,7 @@ ForEachMacros:
   - 'perf_config_sections__for_each_entry'
   - 'perf_config_set__for_each_entry'
   - 'perf_cpu_map__for_each_cpu'
+  - 'perf_cpu_map__for_each_cpu_skip_any'
   - 'perf_cpu_map__for_each_idx'
   - 'perf_evlist__for_each_entry'
   - 'perf_evlist__for_each_entry_reverse'
@@ -639,7 +658,6 @@ ForEachMacros:
   - 'shost_for_each_device'
   - 'sk_for_each'
   - 'sk_for_each_bound'
-  - 'sk_for_each_bound_bhash2'
   - 'sk_for_each_entry_offset_rcu'
   - 'sk_for_each_from'
   - 'sk_for_each_rcu'
@@ -653,6 +671,7 @@ ForEachMacros:
   - 'snd_soc_dapm_widget_for_each_path_safe'
   - 'snd_soc_dapm_widget_for_each_sink_path'
   - 'snd_soc_dapm_widget_for_each_source_path'
+  - 'sparsebit_for_each_set_range'
   - 'strlist__for_each_entry'
   - 'strlist__for_each_entry_safe'
   - 'sym_for_each_insn'
@@ -662,7 +681,6 @@ ForEachMacros:
   - 'tcf_act_for_each_action'
   - 'tcf_exts_for_each_action'
   - 'ttm_resource_manager_for_each_res'
-  - 'twsk_for_each_bound_bhash2'
   - 'udp_portaddr_for_each_entry'
   - 'udp_portaddr_for_each_entry_rcu'
   - 'usb_hub_for_each_child'
@@ -686,6 +704,9 @@ ForEachMacros:
   - 'xbc_node_for_each_child'
   - 'xbc_node_for_each_key_value'
   - 'xbc_node_for_each_subkey'
+  - 'ynl_attr_for_each'
+  - 'ynl_attr_for_each_nested'
+  - 'ynl_attr_for_each_payload'
   - 'zorro_for_each_dev'
 
 IncludeBlocks: Preserve

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-clang-format-for-each-macro-update-604ee79ca29a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


